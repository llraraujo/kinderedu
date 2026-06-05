import 'package:kinderedu/models/header_model.dart';
import 'package:flutter/material.dart';
import '../models/profile_model.dart';

class ProfileController {
  // Dados do usuário logado (Mãe/Responsável)

  final List<EmergencyContact> _emergencyContacts = [
    EmergencyContact(name: 'João Silva (Pai)', phone: '(11) 98765-1234'),
    EmergencyContact(name: 'Avó Materna', phone: '(11) 97654-3210'),
  ];

  UserProfile getUserProfile() {
    return UserProfile(
      name: 'Maria Silva',
      cpf: "111.111.111-11",
      role: 'Responsável',
      email: 'maria.silva@email.com',
      phone: '(11) 98765-4321',
      imageUrl: 'https://via.placeholder.com/150', // Substituir pela foto da Maria
    );
  }

  // Método que será chamado ao clicar em "Salvar" no dialog
  void updateUserProfile({
    required String name,
    required String cpf,
    required String email,
    required String phone,
  }) {
    // Aqui seria implementada a lógica de persistência (API REST, Firebase, etc.)
    // Exemplo:
    // api.updateUser(name, cpf, email, phone);
  }

  void updateChildHealthInfo({required String allergies, required String medications}) {
    // Lógica para enviar os dados para a API / Firebase
  }

  // Adiciona um novo contato
  void addEmergencyContact(String name, String phone) {
    _emergencyContacts.add(EmergencyContact(name: name, phone: phone));
  }

  // Remove um contato
  void removeEmergencyContact(EmergencyContact contact) {
    _emergencyContacts.remove(contact);
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

  // Retorna os dados de saúde da criança
  ChildHealthInfo getChildHealthInfo() {
    return ChildHealthInfo(
      allergies: 'Lactose',
      medications: 'Nenhuma',
    );
  }

  // Lista de contatos de emergência
  List<EmergencyContact> getEmergencyContacts() {
    return _emergencyContacts;
  }

  List<ProfileMenuOption> getAccountOptions() {
    return [
      ProfileMenuOption(title: 'Editar Perfil', icon: Icons.person_outline, color: Colors.blue, onTap: () {})
    ];
  }

  List<ProfileMenuOption> getEmergencyOptions() {
    return [
      ProfileMenuOption(title: 'Contatos de Emergência', icon: Icons.favorite_border, color: Colors.purple, onTap: () {}),
      ProfileMenuOption(title: 'Informações de Saúde', icon: Icons.medical_services_outlined, color: Colors.purple, onTap: () {}),
    ];
  }

  List<ProfileMenuOption> getSecurityOptions() {
    return [
      ProfileMenuOption(title: 'Privacidade', icon: Icons.shield_outlined, color: Colors.blueAccent, onTap: () {}),
    ];
  }
}