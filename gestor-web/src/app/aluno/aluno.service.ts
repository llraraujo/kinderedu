import { Injectable } from '@angular/core';
import { Observable, delay, of } from 'rxjs';
import { Aluno } from './aluno.model';

@Injectable({
  providedIn: 'root'
})
export class AlunoService {
  private alunosDB: Aluno[] = [];

  getAlunos(): Observable<Aluno[]> {
    return of(this.alunosDB).pipe(delay(500));
  }

  cadastrarAluno(aluno: Aluno): Observable<Aluno> {
    const novoAluno = { ...aluno, id: Math.random().toString(36).substring(2, 9) };
    this.alunosDB.push(novoAluno);
    return of(novoAluno).pipe(delay(800));
  }
}
