import 'package:flutter/material.dart';

class DiaryEntry {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color color;

  DiaryEntry({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
  });
}