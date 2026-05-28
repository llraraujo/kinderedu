import 'package:kinderedu/models/header_model.dart';

import '../models/profile_model.dart';

class ProfileController {
  // Dados do usuário logado (Mãe/Responsável)
  UserProfile getUserProfile() {
    return UserProfile(
      name: 'Maria Silva',
      role: 'Responsável',
      email: 'maria.silva@email.com',
      phone: '(11) 98765-4321',
      imageUrl: 'https://via.placeholder.com/150', // Substituir pela foto da Maria
    );
  }

 LinkedChild getLinkedChild() {
    return LinkedChild(
      name: 'Ana Clara',
      age: '8 meses',
      imageUrl: 'https://via.placeholder.com/150', // Substituir pela foto da Ana Clara
    );
  }

  ChildProfile getChildProfile() {
    return childProfileHeader;
  }

  // Lista de contatos de emergência
  List<EmergencyContact> getEmergencyContacts() {
    return [
      EmergencyContact(
        name: 'João Silva (Pai)',
        phone: '(11) 98765-1234',
      ),
      EmergencyContact(
        name: 'Avó Materna',
        phone: '(11) 97654-3210',
      ),
    ];
  }
}