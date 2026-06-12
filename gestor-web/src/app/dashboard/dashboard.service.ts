import { Injectable, inject } from '@angular/core';
import { Observable, of } from 'rxjs';
import { DashboardStats } from './dashboard.model';
import {TurmaService} from '../turma/turma.service';
import {ProfessorService} from '../professor/professor.service';
import {AlunoService} from '../aluno/aluno.service';

@Injectable({ providedIn: 'root' })
export class DashboardService {

 private turmaService = inject(TurmaService);
 private professorService = inject(ProfessorService);
 private alunoService = inject(AlunoService);

  getStats(): Observable<DashboardStats> {
    let quantidadeturma = 0;
    let quantidadeProfessor= 0;
    let quantidadeAluno = 0;
    this.turmaService.getTurmas().subscribe(data => quantidadeturma = data.length);
    this.professorService.getProfessores().subscribe(data => quantidadeProfessor = data.length);
    this.alunoService.getAlunos().subscribe(data => quantidadeAluno = data.length);
    return of({
      turmasCount: quantidadeturma,
      professoresCount: quantidadeProfessor,
      alunosCount: quantidadeAluno
    });
  }
}
