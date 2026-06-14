import { Component, EventEmitter, Input, Output, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Turma } from '../../turma/turma.model';

@Component({
  selector: 'app-aluno-dialog',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './aluno-dialog.component.html',
  styleUrls: ['./aluno-dialog.component.scss'],
})
export class AlunoDialogComponent {
  @Output() closeDialog = new EventEmitter<void>();
  @Output() saveAluno = new EventEmitter<any>();
  @Input() turmas: Turma[] = [];

  private fb = inject(FormBuilder);
  alunoForm: FormGroup;

  constructor() {
    this.alunoForm = this.fb.group({
      // Bloco: Aluno
      nomeCompleto: ['', Validators.required],
      matricula: ['', Validators.required],
      dataNascimento: ['', Validators.required],
      turmaId: ['', Validators.required],

      // Bloco: Responsável
      nomeResponsavel: ['', Validators.required],
      cpf: ['', [Validators.required, Validators.pattern(/^\d{3}\.\d{3}\.\d{3}-\d{2}$/)]],
      email: ['', [Validators.required, Validators.email]],
      telefone: ['', Validators.required],
    });
  }

  onCancel(): void {
    this.closeDialog.emit();
  }

  onSubmit(): void {
    if (this.alunoForm.valid) {
      this.saveAluno.emit(this.alunoForm.value);
      this.saveAluno.emit({
        ...this.alunoForm.value,
        cpf: this.onlyDigits(this.alunoForm.value.cpf),
      });
    } else {
      this.alunoForm.markAllAsTouched();
    }
  }

  onCpfInput(event: Event): void {
    const input = event.target as HTMLInputElement;
    const formattedCpf = this.formatCpf(input.value);

    this.alunoForm.get('cpf')?.setValue(formattedCpf, { emitEvent: false });
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
