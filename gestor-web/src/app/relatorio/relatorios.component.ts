import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

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

  // Armazenamento de Dados
  turmas: Turma[] = [];
  alunos: Aluno[] = [];
  professores: Professor[] = [];

  // Controle de Estado da Interface (Paineis abertos/fechados)
  paineis = {
    turmas: false,
    alunos: false,
    professores: false
  };

  // Controle das Checkboxes (Armazena os IDs selecionados para exportação)
  selecoes = {
    turmas: new Set<string>(),
    alunos: new Set<string>(),
    professores: new Set<string>()
  };

  ngOnInit(): void {
    this.carregarDados();
  }

  carregarDados(): void {
    this.turmaService.getTurmas().subscribe(data => this.turmas = data);
    this.alunoService.getAlunos().subscribe(data => this.alunos = data);
    this.professorService.getProfessores().subscribe(data => this.professores = data);
  }

  // Alterna a visibilidade do painel
  togglePainel(painel: 'turmas' | 'alunos' | 'professores'): void {
    this.paineis[painel] = !this.paineis[painel];
  }

  // Lida com o clique nas checkboxes
  toggleSelecao(tipo: 'turmas' | 'alunos' | 'professores', id: string): void {
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
}
