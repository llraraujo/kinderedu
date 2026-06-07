import { Injectable } from '@angular/core';
import { Observable, delay, of } from 'rxjs';
import { LoginCredentials, AuthResponse } from './auth.model';

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  // Simulação de uma chamada à API de autenticação
  login(credentials: LoginCredentials): Observable<AuthResponse> {
    console.log('Autenticando gestor...', credentials);
    // Mock de resposta bem-sucedida após 1 segundo
    return of({ token: 'jwt-token-mock', user: { role: 'gestor' } }).pipe(delay(1000));
  }
}
