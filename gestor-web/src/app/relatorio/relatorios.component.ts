import { ChangeDetectorRef, Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { catchError, forkJoin, of } from 'rxjs';

// Importando os serviços criados anteriormente
import { TurmaService } from '../turma/turma.service';
import { AlunoService } from '../aluno/aluno.service';
import { ProfessorService } from '../professor/professor.service';

// Importando as interfaces
import { Turma } from '../turma/turma.model';
import { Aluno } from '../aluno/aluno.model';
import { Professor } from '../professor/professor.model';

@Component({
  selector: 'app-relatorios',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './relatorios.component.html',
  styleUrls: ['./relatorios.component.scss']
})
export class RelatoriosComponent implements OnInit {
  // Injeção de dependências
  private turmaService = inject(TurmaService);
  private alunoService = inject(AlunoService);
  private professorService = inject(ProfessorService);
  private cdr = inject(ChangeDetectorRef);

  // Armazenamento de Dados
  turmas: Turma[] = [];
  alunos: Aluno[] = [];
  professores: Professor[] = [];
  isLoading = true;

  // Controle de Estado da Interface (Paineis abertos/fechados)
  paineis = {
    turmas: false,
    alunos: false,
    professores: false
  };

  // Controle das Checkboxes (Armazena os IDs selecionados para exportação)
  selecoes = {
    turmas: new Set<number>(),
    alunos: new Set<number>(),
    professores: new Set<number>()
  };

  ngOnInit(): void {
    this.carregarDados();
  }

  carregarDados(): void {
    this.isLoading = true;
    this.cdr.detectChanges();

    forkJoin({
      turmas: this.turmaService.getTurmas().pipe(
        catchError((err) => {
          console.error('Erro ao carregar turmas no relatorio', err);
          return of([] as Turma[]);
        }),
      ),
      alunos: this.alunoService.getAlunos().pipe(
        catchError((err) => {
          console.error('Erro ao carregar alunos no relatorio', err);
          return of([] as Aluno[]);
        }),
      ),
      professores: this.professorService.getProfessores().pipe(
        catchError((err) => {
          console.error('Erro ao carregar professores no relatorio', err);
          return of([] as Professor[]);
        }),
      ),
    }).subscribe(({ turmas, alunos, professores }) => {
      this.turmas = turmas;
      this.alunos = alunos;
      this.professores = professores;
      this.isLoading = false;
      this.removerSelecoesInvalidas();
      this.cdr.detectChanges();
    });
  }

  // Alterna a visibilidade do painel
  togglePainel(painel: 'turmas' | 'alunos' | 'professores'): void {
    this.paineis[painel] = !this.paineis[painel];
  }

  // Lida com o clique nas checkboxes
  toggleSelecao(tipo: 'turmas' | 'alunos' | 'professores', id: number): void {
    if (this.selecoes[tipo].has(id)) {
      this.selecoes[tipo].delete(id);
    } else {
      this.selecoes[tipo].add(id);
    }
  }

  // Simula a ação de exportação
  exportar(tipo: 'turmas' | 'alunos' | 'professores'): void {
    const idsSelecionados = Array.from(this.selecoes[tipo]);

    if (idsSelecionados.length === 0) {
      alert('Selecione ao menos um item para exportar.');
      return;
    }

    console.log(`Exportando ${tipo} com IDs:`, idsSelecionados);
    // Aqui entraria a chamada para a API gerar o PDF ou Excel
  }

  private removerSelecoesInvalidas(): void {
    this.sincronizarSelecao('turmas', this.turmas);
    this.sincronizarSelecao('alunos', this.alunos);
    this.sincronizarSelecao('professores', this.professores);
  }

  private sincronizarSelecao(
    tipo: 'turmas' | 'alunos' | 'professores',
    itens: Array<{ id?: number }>,
  ): void {
    const idsValidos = new Set(
      itens
        .map((item) => item.id)
        .filter((id): id is number => id !== undefined && id !== null),
    );

    this.selecoes[tipo].forEach((id) => {
      if (!idsValidos.has(id)) {
        this.selecoes[tipo].delete(id);
      }
    });
  }
}
