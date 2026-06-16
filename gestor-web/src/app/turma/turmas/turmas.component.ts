import { ChangeDetectorRef, Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { MatSnackBar, MatSnackBarModule } from '@angular/material/snack-bar';
import { TurmaDialogComponent } from '../turma-dialog/turma-dialog.component';
import { TurmaService } from '../turma.service';
import { Turma } from '../turma.model';

@Component({
  selector: 'app-turmas',
  standalone: true,
  imports: [CommonModule, RouterModule, MatSnackBarModule, TurmaDialogComponent],
  templateUrl: './turmas.component.html',
  styleUrls: ['./turmas.component.scss']
})
export class TurmasComponent implements OnInit {
  private turmaService = inject(TurmaService);
  private snackBar = inject(MatSnackBar);
  private cdr = inject(ChangeDetectorRef);
  turmas: Turma[] = [];
  isModalOpen: boolean = false;
  isLoading: boolean = true;

  ngOnInit(): void {
    this.carregarTurmas();
  }

  carregarTurmas(): void {
    this.isLoading = true;
    this.turmaService.getTurmas().subscribe({
      next:  (data) => {
        this.turmas = data;
        this.isLoading = false;
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('Erro ao carregar turmas', err);
        this.turmas = [];
        this.isLoading = false;
        this.cdr.detectChanges();
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
      next: () => {
        this.carregarTurmas();
        this.snackBar.open('Turma cadastrada com sucesso.', 'Fechar', {
          duration: 4000,
          horizontalPosition: 'right',
          verticalPosition: 'top',
          panelClass: ['snackbar-success']
        });
        this.closeDialog();
        this.cdr.detectChanges();
      },
      error: (err) => {
        console.error('Erro ao cadastrar turma', err);
        this.snackBar.open('Erro ao cadastrar turma. Tente novamente.', 'Fechar', {
          duration: 6000,
          horizontalPosition: 'right',
          verticalPosition: 'top',
          panelClass: ['snackbar-error']
        });
      }
    });
  }

  navigateTo(id: any ):void{

  }
}
