import { Injectable, inject } from '@angular/core';
import { Observable, forkJoin, map } from 'rxjs';
import { DashboardStats } from './dashboard.model';
import { TurmaService } from '../turma/turma.service';
import { ProfessorService } from '../professor/professor.service';
import { AlunoService } from '../aluno/aluno.service';

@Injectable({ providedIn: 'root' })
export class DashboardService {
  private turmaService = inject(TurmaService);
  private professorService = inject(ProfessorService);
  private alunoService = inject(AlunoService);

  getStats(): Observable<DashboardStats> {
    return forkJoin({
      turmas: this.turmaService.getTurmas(),
      professores: this.professorService.getProfessores(),
      alunos: this.alunoService.getAlunos(),
    }).pipe(
      map(({ turmas, professores, alunos }) => ({
        turmasCount: turmas.length,
        professoresCount: professores.length,
        alunosCount: alunos.length,
      })),
    );
  }
}
