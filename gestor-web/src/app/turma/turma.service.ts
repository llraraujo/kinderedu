import { Injectable, inject } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Turma } from './turma.model';

@Injectable({
  providedIn: 'root',
})
export class TurmaService {
  private http = inject(HttpClient);
  private apiUrl = 'http://localhost:8080';

  getTurmas(): Observable<Turma[]> {
    return this.http.get<Turma[]>(`${this.apiUrl}/turmas`);
  }

  cadastrarTurma(turma: Turma): Observable<Turma> {
    const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
    return this.http.post<Turma>(`${this.apiUrl}/turmas`, turma, { headers });
  }
}
