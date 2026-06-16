import { inject, Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Professor } from './professor.model';

@Injectable({
  providedIn: 'root',
})
export class ProfessorService {
  private apiUrl = 'http://localhost:8080';
  private http = inject(HttpClient);

  getProfessores(): Observable<Professor[]> {
    return this.http.get<Professor[]>(`${this.apiUrl}/professores`);
  }

  cadastrarProfessor(professor: Professor): Observable<Professor> {
    const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
    return this.http.post<Professor>(`${this.apiUrl}/professores`, professor, { headers });
  }
}
