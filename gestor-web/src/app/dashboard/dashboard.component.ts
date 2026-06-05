import { Component, OnInit, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterModule } from '@angular/router';
import { DashboardService } from './dashboard.service';
import { DashboardStats } from './dashboard.model';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.scss']
})
export class DashboardComponent implements OnInit {
  private dashboardService = inject(DashboardService);
  private router = inject(Router);

  stats: DashboardStats = { turmasCount: 0, professoresCount: 0, alunosCount: 0 };

  ngOnInit(): void {
    this.dashboardService.getStats().subscribe(data => this.stats = data);
  }

  logout(): void {
    localStorage.removeItem('token');
    this.router.navigate(['/login']);
  }

  navigateTo(route: string): void {
    this.router.navigate([`/dashboard/${route}`]);
  }
}
