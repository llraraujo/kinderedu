import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { ProfessorDialogComponent } from '../professor-dialog/professor-dialog.component';
import { ProfessorService } from '../professor.service';
import { Professor } from '../professor.model';
import { TurmaService } from '../../turma/turma.service';
import { Turma } from '../../turma/turma.model';

@Component({
  selector: 'app-professores',
  standalone: true,
  imports: [CommonModule, RouterModule, MatSnackBarModule, ProfessorDialogComponent],
  templateUrl: './professores.component.html',
  styleUrls: ['./professores.component.scss']
})
export class ProfessoresComponent implements OnInit {
  private professorService = inject(ProfessorService);
  private turmaService = inject(TurmaService);
  private snackBar = inject(MatSnackBar);


  professores: Professor[] = [];
  turmas: Turma[] = [];
  isModalOpen: boolean = false;
  isLoading: boolean = true;

  ngOnInit(): void {
    this.carregarProfessores();
    this.carregarTurmas();
  }

  carregarProfessores(): void {
    this.professorService.getProfessores().subscribe({
      next: (data) => {
        this.professores = data;
        this.isLoading = false;
      },
    });
  }

  carregarTurmas(): void {
    this.turmaService.getTurmas().subscribe({
      next: (data) => {
        this.turmas = data;
      },
    });
  }


  openDialog(): void {
    this.isModalOpen = true;
  }

  closeDialog(): void {
    this.isModalOpen = false;
  }

  onSalvarProfessor(novoProfessor: Professor): void {
    this.professorService.cadastrarProfessor(novoProfessor).subscribe({
      next: (profCadastrado) => {
        this.professores.push(profCadastrado);
        this.snackBar.open('Professor cadastrado com sucesso.', 'Fechar', {
          duration: 4000,
          horizontalPosition: 'right',
          verticalPosition: 'top',
          panelClass: ['snackbar-success']
        });
        this.closeDialog();
      },
      error: (err) => {
        console.error('Erro ao cadastrar professor', err);
        this.snackBar.open('Erro ao cadastrar professor. Tente novamente.', 'Fechar', {
          duration: 6000,
          horizontalPosition: 'right',
          verticalPosition: 'top',
          panelClass: ['snackbar-error']
        });
      },
    });
  }

  getTurmaNome(idTurma: number | string): string {
    const turma = this.turmas.find((item) => String(item.id) === String(idTurma));
    return turma?.nome ?? 'Sem turma';
  }
}
