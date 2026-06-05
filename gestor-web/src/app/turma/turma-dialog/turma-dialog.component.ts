import { Component, EventEmitter, Output, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';

@Component({
  selector: 'app-turma-dialog',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './turma-dialog.component.html',
  styleUrls: ['./turma-dialog.component.scss']
})
export class TurmaDialogComponent {
  @Output() closeDialog = new EventEmitter<void>();
  @Output() saveTurma = new EventEmitter<any>();

  private fb = inject(FormBuilder);
  turmaForm: FormGroup;

  // Mock para o select de professores (futuramente viria de um input ou service)
  professores = [
    { id: '1', nome: 'Ana Silva' },
    { id: '2', nome: 'Carlos Edu' }
  ];

  constructor() {
    this.turmaForm = this.fb.group({
      nome: ['', Validators.required],
      anoSerie: ['', Validators.required],
      turno: ['Manhã', Validators.required],
      professorId: ['', Validators.required],
      capacidade: [20, [Validators.required, Validators.min(1)]]
    });
  }

  onCancel(): void {
    this.closeDialog.emit();
  }

  onSubmit(): void {
    if (this.turmaForm.valid) {
      this.saveTurma.emit(this.turmaForm.value);
    } else {
      this.turmaForm.markAllAsTouched();
    }
  }
}
