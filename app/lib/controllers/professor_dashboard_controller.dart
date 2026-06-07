import '../models/professor_dashboard_model.dart';

class EducatorDashboardController {
  // Simula o carregamento dos dados da professora logada
  ProfessorProfile getProfessorProfile() {
    return ProfessorProfile(
      name: 'Profa. Carla',
      className: 'Turma Berçário A',
      studentCount: 4,
      logoUrl: 'https://via.placeholder.com/150', // Logo Kinder Edu
    );
  }

  // Simula a busca dos alunos vinculados a esta turma
  List<StudentOverview> getClassStudents() {
    return [
      StudentOverview(
        id: '1',
        name: 'Maria Laura',
        age: '2 anos',
        responsibleName: 'Maria Silva',
        imageUrl: 'images/perfil.jpg',
      ),
      StudentOverview(
        id: '2',
        name: 'Pedro Henrique',
        age: '2 anos e 3 meses',
        responsibleName: 'João Costa',
        imageUrl: 'images/perfil2.png',
      ),
      StudentOverview(
        id: '3',
        name: 'Sofia Maria',
        age: '2 anos',
        responsibleName: 'Ana Santos',
        imageUrl: 'images/perfil3.png',
      ),
      StudentOverview(
        id: '4',
        name: 'Lucas Gabriel',
        age: '2 anos',
        responsibleName: 'Carla Souza',
        imageUrl: 'images/perfil4.png',
      ),
    ];
  }
}