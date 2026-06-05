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
  },
  {
    path: 'turmas',
    canActivate: [authGuard],
    loadComponent: () => import('./turma/turmas/turmas.component').then(m => m.TurmasComponent)
  },
  {
    path: 'professores',
    canActivate: [authGuard],
    loadComponent: () => import('./professor/professores/professores.component').then(m => m.ProfessoresComponent)
  },
  {
    path: 'alunos',
    canActivate: [authGuard],
    loadComponent: () => import('./aluno/alunos/alunos.component').then(m => m.AlunosComponent)
  },
  {
    path: 'relatorios',
    canActivate: [authGuard],
    loadComponent: () => import('./placeholder.component').then(m => m.PlaceholderComponent)
  },
  { path: '**', redirectTo: 'login' }
];
