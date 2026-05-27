import 'package:flutter/material.dart';
import '../models/diary_model.dart';

class DiaryController {
  // Simula a busca de eventos do diário
  List<DiaryEntry> getDiaryEntries() {
    return [
      DiaryEntry(
        title: 'Mamadeira',
        description: '150ml • Mamou tudo',
        time: '14:30',
        icon: Icons.local_drink,
        color: Colors.blue,
      ),
      DiaryEntry(
        title: 'Soneca da Tarde',
        description: '45 minutos • Dormiu tranquila',
        time: '13:00',
        icon: Icons.nightlight_round,
        color: Colors.purple,
      ),
      DiaryEntry(
        title: 'Almoço',
        description: 'Papinha de legumes • Comeu bem',
        time: '12:00',
        icon: Icons.restaurant,
        color: Colors.orange,
      ),
      DiaryEntry(
        title: 'Troca de Fralda',
        description: 'Fralda suja',
        time: '11:30',
        icon: Icons.child_care,
        color: Colors.green,
      ),
      DiaryEntry(
        title: 'Mamadeira',
        description: '120ml • Aceitou bem',
        time: '10:00',
        icon: Icons.local_drink,
        color: Colors.blue,
      ),
      DiaryEntry(
        title: 'Soneca da Manhã',
        description: '1 hora • Acordou disposta',
        time: '09:00',
        icon: Icons.nightlight_round,
        color: Colors.purple,
      ),
    ];
  }
}