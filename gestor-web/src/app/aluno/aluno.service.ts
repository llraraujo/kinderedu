import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Aluno } from './aluno.model';

@Injectable({
  providedIn: 'root',
})
export class AlunoService {
  private apiUrl = 'http://localhost:8080';
  private http = inject(HttpClient);

  getAlunos(): Observable<Aluno[]> {
    return this.http.get<Aluno[]>(`${this.apiUrl}/alunos`);
  }

  cadastrarAluno(aluno: Aluno): Observable<Aluno> {
    const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
    return this.http.post<Aluno>(`${this.apiUrl}/alunos`, aluno, { headers });
  }
}
