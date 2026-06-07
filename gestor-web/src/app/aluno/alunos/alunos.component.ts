import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { AlunoDialogComponent } from '../aluno-dialog/aluno-dialog.component';
import { AlunoService } from '../aluno.service';
import { Aluno } from '../aluno.model';

@Component({
  selector: 'app-alunos',
  standalone: true,
  imports: [CommonModule, RouterModule, AlunoDialogComponent],
  templateUrl: './alunos.component.html',
  styleUrls: ['./alunos.component.scss']
})
export class AlunosComponent implements OnInit {
  private alunoService = inject(AlunoService);

  alunos: Aluno[] = [];
  isModalOpen: boolean = false;
  isLoading: boolean = true;

  ngOnInit(): void {
    this.carregarAlunos();
  }

  carregarAlunos(): void {
    this.alunoService.getAlunos().subscribe({
      next: (data) => {
        this.alunos = data;
        this.isLoading = false;
      }
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
        this.closeDialog();
      },
      error: (err) => console.error('Erro ao cadastrar aluno', err)
    });
  }
}
