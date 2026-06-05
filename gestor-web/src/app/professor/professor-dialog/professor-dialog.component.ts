import { Component, EventEmitter, Output, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-professor-dialog',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './professor-dialog.component.html',
  styleUrls: ['./professor-dialog.component.scss']
})
export class ProfessorDialogComponent {
  @Output() closeDialog = new EventEmitter<void>();
  @Output() saveProfessor = new EventEmitter<any>();

  private fb = inject(FormBuilder);
  professorForm: FormGroup;

  // Mock de turmas para o select
  turmas = [
    { id: 't1', nome: 'Jardim I - A' },
    { id: 't2', nome: 'Maternal II - B' }
  ];

  constructor() {
    this.professorForm = this.fb.group({
      nomeCompleto: ['', [Validators.required, Validators.minLength(3)]],
      email: ['', [Validators.required, Validators.email]],
      cpf: ['', [Validators.required]], // Idealmente, usar um validador de CPF customizado
      telefone: ['', [Validators.required]],
      turmaId: ['', Validators.required]
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
