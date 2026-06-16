import 'package:flutter/material.dart';

class DiaryEntry {
  final int year;
  final IconData icon;
  final Color iconColor;

  DiaryEntry({required this.year, required this.icon, required this.iconColor});
}

class DiaryMonth {
  final String month;
  final IconData icon;
  final Color iconColor;

  DiaryMonth({
    required this.month,
    required this.icon,
    required this.iconColor,
  });
}

class DiaryDayEntry {
  final int day;
  final String month;
  final int year;
  final bool hasReport;

  DiaryDayEntry({
    required this.day,
    required this.month,
    required this.year,
    this.hasReport = true,
  });
}

class DayActivity {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color color;

  DayActivity({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
  });

  factory DayActivity.fromJson(Map<String, dynamic> json) {
    final tipo = json['tipoAtividade']?.toString() ?? '';

    return DayActivity(
      title: json['title']?.toString() ?? _titleForType(tipo),
      description: json['description']?.toString() ?? '',
      time: json['time']?.toString() ?? '',
      icon: _iconForType(tipo),
      color: _colorForType(tipo),
    );
  }

  static String _titleForType(String tipo) {
    switch (tipo) {
      case 'ALIMENTACAO':
        return 'Refeicao';
      case 'SONECA':
        return 'Soneca';
      case 'HIGIENE':
        return 'Higiene';
      default:
        return 'Atividade';
    }
  }

  static IconData _iconForType(String tipo) {
    switch (tipo) {
      case 'ALIMENTACAO':
        return Icons.restaurant;
      case 'SONECA':
        return Icons.nightlight_round;
      case 'HIGIENE':
        return Icons.child_care;
      default:
        return Icons.description_outlined;
    }
  }

  static Color _colorForType(String tipo) {
    switch (tipo) {
      case 'ALIMENTACAO':
        return Colors.orange;
      case 'SONECA':
        return Colors.purple;
      case 'HIGIENE':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }
}
