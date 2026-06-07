import { Component, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormBuilder, FormGroup, Validators, ReactiveFormsModule } from '@angular/forms';
import { Router } from '@angular/router'; // 1. ALTERAÇÃO: Importar o Router
import { AuthService } from './auth.service';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule],
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent {
  private fb = inject(FormBuilder);
  private authService = inject(AuthService);
  private router = inject(Router); // 2. ALTERAÇÃO: Injetar o Router

  loginForm: FormGroup;
  isPasswordVisible: boolean = false;
  isLoading: boolean = false;

  constructor() {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      senha: ['', [Validators.required, Validators.minLength(6)]]
    });
  }

  togglePasswordVisibility(): void {
    this.isPasswordVisible = !this.isPasswordVisible;
  }

  onSubmit(): void {
    if (this.loginForm.invalid) {
      this.loginForm.markAllAsTouched();
      return;
    }

    this.isLoading = true;
    this.authService.login(this.loginForm.value).subscribe({
      next: (res) => {
        // 3. ALTERAÇÃO: Salvar o token e redirecionar
        localStorage.setItem('token', res.token); // Alimenta o AuthGuard

        this.router.navigate(['/dashboard']); // Navega para a rota principal do Dashboard
        this.isLoading = false;
      },
      error: (err) => {
        console.error('Erro ao realizar login', err);
        this.isLoading = false;
        // Aqui você pode adicionar um serviço de notificação (Toast/Alert) para o usuário
      }
    });
  }
}
