import '../models/student_file_model.dart';

class StudentFileController {
  // Simula a busca da ficha completa baseada no ID do aluno
  StudentFileModel getStudentFile(String studentId) {
    return StudentFileModel(
      responsible: ResponsibleModel(
        name: 'Maria Silva',
        phone: '(11) 99876-5432',
      ),
      emergencyContacts: [
        EmergencyContactModel(name: 'João Silva', relation: 'Pai', phone: '(11) 98765-4321'),
        EmergencyContactModel(name: 'Cláudia Mendes', relation: 'Avó', phone: '(11) 97654-3210'),
      ],
      healthInfo: HealthRecordModel(
        allergies: 'Alergia à proteína do leite de vaca (APLV)',
        medications: 'Nenhuma medicação em uso no momento',
      ),
    );
  }
}