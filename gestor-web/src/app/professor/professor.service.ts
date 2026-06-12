import { inject, Injectable } from '@angular/core';
import { Observable, delay, of } from 'rxjs';
import { Professor } from './professor.model';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';


@Injectable({
  providedIn: 'root',
})
export class ProfessorService {
  // Inicializamos vazio para forçar a exibição do "Empty State"
  private professoresDB: Professor[] = [];
  private apiUrl = 'http://localhost:8080';
  private http = inject(HttpClient);

  getProfessores(): Observable<Professor[]> {
    var observer = this.http.get<Professor[]>(`${this.apiUrl}/professores`);
    observer.subscribe((data) => (this.professoresDB = data));
    return of(this.professoresDB);
  }

  cadastrarProfessor(professor: Professor): Observable<Professor> {
    const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
    return this.http.post<Professor>(`${this.apiUrl}/professores`, professor, { headers });
  }
}
