import { Component, EventEmitter, Output, inject, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { TurmaService } from '../../turma/turma.service';
import { Turma } from '../../turma/turma.model';

@Component({
  selector: 'app-professor-dialog',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './professor-dialog.component.html',
  styleUrls: ['./professor-dialog.component.scss'],
})
export class ProfessorDialogComponent {
  @Output() closeDialog = new EventEmitter<void>();
  @Output() saveProfessor = new EventEmitter<any>();
  @Input() turmas: Turma[] = [];
  private turmaService = inject(TurmaService);

  private fb = inject(FormBuilder);

  professorForm: FormGroup;

  // Mock de turmas para o select

  constructor() {
    this.professorForm = this.fb.group({
      nome: ['', [Validators.required, Validators.minLength(3)]],
      emailInstitucional: ['', [Validators.required, Validators.email]],
      cpf: ['', [Validators.required]], // Idealmente, usar um validador de CPF customizado
      telefone: ['', [Validators.required]],
      idTurma: ['', Validators.required],
    });
  }
  carregarTurmas(): void {
    this.turmaService.getTurmas().subscribe({
      next: (data) => {
        console.log('Turmas carregadas:', data);
        this.turmas.push(...data);
      },
    });
  }

  onCancel(): void {
    this.closeDialog.emit();
  }

  onSubmit(): void {
    if (this.professorForm.valid) {
      this.saveProfessor.emit(this.professorForm.value);
    } else {
      this.professorForm.markAllAsTouched();
    }
  }
}
