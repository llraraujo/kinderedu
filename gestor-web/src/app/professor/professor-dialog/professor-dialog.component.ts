import { Component, EventEmitter, Output, inject, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
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

  private fb = inject(FormBuilder);

  professorForm: FormGroup;

  constructor() {
    this.professorForm = this.fb.group({
      nome: ['', [Validators.required, Validators.minLength(3)]],
      emailInstitucional: ['', [Validators.required, Validators.email]],
      cpf: ['', [Validators.required, Validators.pattern(/^\d{3}\.\d{3}\.\d{3}-\d{2}$/)]],
      telefone: ['', [Validators.required]],
      idTurma: ['', Validators.required],
    });
  }

  onCancel(): void {
    this.closeDialog.emit();
  }

  onCpfInput(event: Event): void {
    const input = event.target as HTMLInputElement;
    const formattedCpf = this.formatCpf(input.value);

    this.professorForm.get('cpf')?.setValue(formattedCpf, { emitEvent: false });
  }

  onSubmit(): void {
    if (this.professorForm.valid) {
      this.saveProfessor.emit({
        ...this.professorForm.value,
        cpf: this.onlyDigits(this.professorForm.value.cpf),
      });
    } else {
      this.professorForm.markAllAsTouched();
    }
  }

  private formatCpf(value: string): string {
    return this.onlyDigits(value)
      .slice(0, 11)
      .replace(/(\d{3})(\d)/, '$1.$2')
      .replace(/(\d{3})(\d)/, '$1.$2')
      .replace(/(\d{3})(\d{1,2})$/, '$1-$2');
  }

  private onlyDigits(value: string): string {
    return value.replace(/\D/g, '');
  }
}
