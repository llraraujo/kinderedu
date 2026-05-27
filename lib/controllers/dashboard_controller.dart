import 'package:flutter/material.dart';
import '../models/dashboard_model.dart'; // Ajuste o import conforme sua estrutura

class DashboardController {
  // Simula a busca de dados do perfil da criança
  ChildProfile getChildProfile() {
    return ChildProfile(
      name: 'Ana Clara',
      age: '8 meses',
      imageUrl: 'https://via.placeholder.com/150', // Substitua pela URL da foto
      currentDate: '27 de Novembro, 2025 • Quarta-feira',
    );
  }

  // Simula a busca das atividades do dia
  List<ActivitySummary> getTodayActivities() {
    return [
      ActivitySummary(
        title: 'Mamadas',
        count: 3,
        lastTime: '14:30',
        icon: Icons.local_drink, // Ícone aproximado
        primaryColor: Colors.blueAccent,
        backgroundColor: Colors.blue.withOpacity(0.1),
      ),
      ActivitySummary(
        title: 'Sonecas',
        count: 2,
        lastTime: '13:00',
        icon: Icons.nightlight_round,
        primaryColor: Colors.purpleAccent,
        backgroundColor: Colors.purple.withOpacity(0.1),
      ),
      ActivitySummary(
        title: 'Fraldas',
        count: 5,
        lastTime: '11:30',
        icon: Icons.child_care,
        primaryColor: Colors.green,
        backgroundColor: Colors.green.withOpacity(0.1),
      ),
      ActivitySummary(
        title: 'Refeições',
        count: 2,
        lastTime: '12:00',
        icon: Icons.restaurant,
        primaryColor: Colors.orange,
        backgroundColor: Colors.orange.withOpacity(0.1),
      ),
    ];
  }
}