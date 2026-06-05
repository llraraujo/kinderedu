import { Injectable } from '@angular/core';
import { Observable, delay, of } from 'rxjs';
import { Turma } from './turma.model';

@Injectable({
  providedIn: 'root'
})
export class TurmaService {
  // Simulando um banco de dados vazio para exibir o Empty State da imagem
  private turmasDB: Turma[] = [];

  getTurmas(): Observable<Turma[]> {
    return of(this.turmasDB).pipe(delay(500));
  }

  cadastrarTurma(turma: Turma): Observable<Turma> {
    const novaTurma = { ...turma, id: Math.random().toString(36).substr(2, 9) };
    this.turmasDB.push(novaTurma);
    return of(novaTurma).pipe(delay(800)); // Simula tempo de rede
  }
}
