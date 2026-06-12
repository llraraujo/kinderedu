import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { AlunoDialogComponent } from '../aluno-dialog/aluno-dialog.component';
import { AlunoService } from '../aluno.service';
import { Aluno } from '../aluno.model';
import { TurmaService } from '../../turma/turma.service';
import { Turma } from '../../turma/turma.model';

@Component({
  selector: 'app-alunos',
  standalone: true,
  imports: [CommonModule, RouterModule, MatSnackBarModule, AlunoDialogComponent],
  templateUrl: './alunos.component.html',
  styleUrls: ['./alunos.component.scss'],
})
export class AlunosComponent implements OnInit {
  private alunoService = inject(AlunoService);
  private turmaService = inject(TurmaService);
  private snackBar = inject(MatSnackBar);


  alunos: Aluno[] = [];
  turmas: Turma[] = [];
  isModalOpen: boolean = false;
  isLoading: boolean = true;

  ngOnInit(): void {
    this.carregarAlunos();
    this.carregarTurmas();
  }

  carregarAlunos(): void {
    this.alunoService.getAlunos().subscribe({
      next: (data) => {
        this.alunos.push(...data);
        this.isLoading = false;
      },
    });
  }

  carregarTurmas(): void {
    this.turmaService.getTurmas().subscribe({
      next: (data) => {
        this.turmas.push(...data);
      },
    });
  }

  openDialog(): void {
    this.isModalOpen = true;
  }

  closeDialog(): void {
    this.isModalOpen = false;
  }

  onSalvarAluno(novoAluno: Aluno): void {
    this.alunoService.cadastrarAluno(novoAluno).subscribe({
      next: (alunoCadastrado) => {
        this.alunos.push(alunoCadastrado);
        this.snackBar.open('Aluno cadastrado com sucesso.', 'Fechar', {
          duration: 4000,
          horizontalPosition: 'right',
          verticalPosition: 'top',
          panelClass: ['snackbar-success'],
        });
        this.closeDialog();
      },
      error: (err) => {
        console.error('Erro ao cadastrar aluno', err);
        this.snackBar.open('Erro ao cadastrar aluno. Tente novamente.', 'Fechar', {
          duration: 6000,
          horizontalPosition: 'right',
          verticalPosition: 'top',
          panelClass: ['snackbar-error'],
        });
      },
    });
  }

  getTurmaNome(turmaId: number | string): string {
    const turma = this.turmas.find((item) => String(item.id) === String(turmaId));
    return turma?.nome ?? 'Sem turma';
  }
}
