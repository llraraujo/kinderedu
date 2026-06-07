import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { ProfessorDialogComponent } from '../professor-dialog/professor-dialog.component';
import { ProfessorService } from '../professor.service';
import { Professor } from '../professor.model';

@Component({
  selector: 'app-professores',
  standalone: true,
  imports: [CommonModule, RouterModule, ProfessorDialogComponent],
  templateUrl: './professores.component.html',
  styleUrls: ['./professores.component.scss']
})
export class ProfessoresComponent implements OnInit {
  private professorService = inject(ProfessorService);

  professores: Professor[] = [];
  isModalOpen: boolean = false;
  isLoading: boolean = true;

  ngOnInit(): void {
    this.carregarProfessores();
  }

  carregarProfessores(): void {
    this.professorService.getProfessores().subscribe({
      next: (data) => {
        this.professores = data;
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

  onSalvarProfessor(novoProfessor: Professor): void {
    this.professorService.cadastrarProfessor(novoProfessor).subscribe({
      next: (profCadastrado) => {
        this.professores.push(profCadastrado);
        this.closeDialog();
      },
      error: (err) => console.error('Erro ao cadastrar professor', err)
    });
  }
}
