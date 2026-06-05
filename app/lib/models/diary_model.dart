import 'package:flutter/material.dart';

class DiaryEntry {
  final int year;
  final IconData icon;
  final Color iconColor;

  DiaryEntry({
    required this.year, 
    required this.icon, 
    required this.iconColor
  });
}

class DiaryMonth {
  final String month;
  final IconData icon;
  final Color iconColor;

  DiaryMonth({
    required this.month, 
    required this.icon, 
    required this.iconColor
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
}