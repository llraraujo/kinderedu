import { Routes } from '@angular/router';
import { inject } from '@angular/core';
import { Router } from '@angular/router';

// Simulação simples de um Guard de Autenticação
const authGuard = () => {
  const router = inject(Router);
  return localStorage.getItem('token') ? true : router.parseUrl('/login');
};

export const routes: Routes = [
  { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
  {
    path: 'login',
    loadComponent: () => import('./login/login.component').then(m => m.LoginComponent)
  },
  {
    path: 'dashboard',
    canActivate: [authGuard],
    loadComponent: () => import('./dashboard/dashboard.component').then(m => m.DashboardComponent),
    children: [
      // Sub-rotas para futuras implementações
      { path: 'turmas', loadComponent: () => import('./placeholder.component').then(m => m.PlaceholderComponent) },
      { path: 'professores', loadComponent: () => import('./placeholder.component').then(m => m.PlaceholderComponent) },
      { path: 'alunos', loadComponent: () => import('./placeholder.component').then(m => m.PlaceholderComponent) },
      { path: 'relatorios', loadComponent: () => import('./placeholder.component').then(m => m.PlaceholderComponent) },
    ]
  },
  { path: '**', redirectTo: 'login' }
];
