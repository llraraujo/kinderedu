import { Injectable, inject } from '@angular/core';
import { Observable, delay, of, catchError, throwError } from 'rxjs';
import { HttpClient, HttpHeaders, HttpParams } from '@angular/common/http';
import { Turma } from './turma.model';

@Injectable({
  providedIn: 'root'
})
export class TurmaService {
  // Simulando um banco de dados vazio para exibir o Empty State da imagem
  private turmasDB: Turma[] = [];
  private http = inject(HttpClient); // Inject the client via inject() API
  private apiUrl = 'http://localhost:8080';

  getTurmas(): Observable<Turma[]> {
    var observer =   this.http.get<Turma[]>(`${this.apiUrl}/turmas`);
    observer.subscribe(data =>  this.turmasDB = data);
    return of(this.turmasDB);
  }

   cadastrarTurma(turma: Turma): Observable<Turma> {
    const headers = new HttpHeaders({ 'Content-Type': 'application/json' });
    return this.http.post<Turma>(`${this.apiUrl}/turmas`, turma, { headers }).pipe(catchError(this.handleError));
  }

  // Error Utility Handler
  private handleError(error: any) {
    console.error('An error occurred:', error);
    return throwError(() => new Error('Something went wrong. Please try again later.'));
  }
}
