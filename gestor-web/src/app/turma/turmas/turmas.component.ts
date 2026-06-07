import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { TurmaDialogComponent } from '../turma-dialog/turma-dialog.component';
import { TurmaService } from '../turma.service';
import { Turma } from '../turma.model';

@Component({
  selector: 'app-turmas',
  standalone: true,
  imports: [CommonModule, RouterModule, TurmaDialogComponent],
  templateUrl: './turmas.component.html',
  styleUrls: ['./turmas.component.scss']
})
export class TurmasComponent implements OnInit {
  private turmaService = inject(TurmaService);

  turmas: Turma[] = [];
  isModalOpen: boolean = false;
  isLoading: boolean = true;

  ngOnInit(): void {
    this.carregarTurmas();
  }

  carregarTurmas(): void {
    this.turmaService.getTurmas().subscribe({
      next: (data) => {
        this.turmas = data;
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

  onSalvarTurma(novaTurma: Turma): void {
    this.turmaService.cadastrarTurma(novaTurma).subscribe({
      next: (turmaCadastrada) => {
        this.turmas.push(turmaCadastrada); // Atualiza a lista
        this.closeDialog(); // Fecha o modal
      },
      error: (err) => console.error('Erro ao cadastrar turma', err)
    });
  }
}
