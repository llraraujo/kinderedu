import { Injectable } from '@angular/core';
import { Observable, delay, of } from 'rxjs';
import { Professor } from './professor.model';

@Injectable({
  providedIn: 'root'
})
export class ProfessorService {
  // Inicializamos vazio para forçar a exibição do "Empty State"
  private professoresDB: Professor[] = [];

  getProfessores(): Observable<Professor[]> {
    return of(this.professoresDB).pipe(delay(500));
  }

  cadastrarProfessor(professor: Professor): Observable<Professor> {
    const novoProfessor = { ...professor, id: Math.random().toString(36).substring(2, 9) };
    this.professoresDB.push(novoProfessor);
    return of(novoProfessor).pipe(delay(800));
  }
}
