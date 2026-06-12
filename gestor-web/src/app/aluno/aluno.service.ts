import { inject, Injectable } from '@angular/core';
import { Observable, delay, of } from 'rxjs';
import { Aluno } from './aluno.model';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Professor } from '../professor/professor.model';

@Injectable({
  providedIn: 'root',
})
export class AlunoService {
  private alunosDB: Aluno[] = [];
  private apiUrl = 'http://localhost:8080';
  private http = inject(HttpClient);

  getAlunos(): Observable<Aluno[]> {
    var observer = this.http.get<Aluno[]>(`${this.apiUrl}/alunos`);
    observer.subscribe((data) => (this.alunosDB = data));
    return of(this.alunosDB);
  }

  cadastrarAluno(aluno: Aluno): Observable<Aluno> {
    const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
    return this.http.post<Aluno>(`${this.apiUrl}/alunos`, aluno, { headers });
  }
}
