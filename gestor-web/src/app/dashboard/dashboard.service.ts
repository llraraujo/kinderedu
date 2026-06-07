import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { DashboardStats } from './dashboard.model';

@Injectable({ providedIn: 'root' })
export class DashboardService {
  getStats(): Observable<DashboardStats> {
    // Mock de dados conforme a imagem
    return of({
      turmasCount: 0,
      professoresCount: 0,
      alunosCount: 0
    });
  }
}
