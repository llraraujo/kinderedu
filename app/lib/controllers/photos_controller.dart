import 'package:flutter/material.dart';

import '../models/photo_model.dart';
import 'package:kinderedu/models/header_model.dart';

class PhotosController {
  ChildProfile getChildProfile() {
    return childProfileHeader;
  }

  List<PhotoEntry> getAvailableYears() {
    return [
      PhotoEntry(
        year: 2025,
        icon: Icons.image,
        iconColor: Colors.pinkAccent,
      ),
      PhotoEntry(
        year: 2024,
        icon: Icons.image,
        iconColor: Colors.pinkAccent,
      ),
    ];
  }

    List<PhotoMonth>? getAvailableMonths(int year) {
    Map<int, List<PhotoMonth>> yearMonths = {
      2026: [
      PhotoMonth(
        month: "Novembro",
        icon: Icons.image,
        iconColor: Colors.pinkAccent,
      ),
      PhotoMonth(
        month: "Outubro",
        icon: Icons.image,
        iconColor: Colors.pinkAccent,
      )],

      2025: [
      PhotoMonth(
        month: "Janeiro",
        icon: Icons.image,
        iconColor: Colors.pinkAccent,
      ),
      PhotoMonth(
        month: "Fevereiro",
        icon: Icons.image,
        iconColor: Colors.pinkAccent,
      )]
    };

    return yearMonths[year];
  }

  List<PhotoDayEntry> getDaysForMonth(String month, int year) {
    
    return List.generate(12, (index) => 27 - index).map((day) {
      return PhotoDayEntry(day: day, month: month, year: year);
    }).toList();
  }

  // Simula a busca das fotos postadas no dia
  List<PhotoGallery> getPhotosGallery(DateTime date) {
    return [
      PhotoGallery(
        imageUrl: 'https://images.unsplash.com/photo-1516627145497-ae6968895b74?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80', // Exemplo de crianças brincando
        description: 'Brincando com os blocos de montar',
        time: '14:30',
      ),
      PhotoGallery(
        imageUrl: 'https://images.unsplash.com/photo-1603354350317-6f7aaa5911c5?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80', // Exemplo de música
        description: 'Atividade de música e artes',
        time: '11:00',
      ),
      PhotoGallery(
        imageUrl: 'https://images.unsplash.com/photo-1519689680058-324335c77eba?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80', // Exemplo de bebê
        description: 'Hora do lanche da manhã',
        time: '09:30',
      ),
    ];
  }
}