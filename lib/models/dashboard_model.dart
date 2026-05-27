import 'package:flutter/material.dart';

class ChildProfile {
  final String name;
  final String age;
  final String imageUrl;
  final String currentDate;

  ChildProfile({
    required this.name,
    required this.age,
    required this.imageUrl,
    required this.currentDate,
  });
}

class ActivitySummary {
  final String title;
  final int count;
  final String lastTime;
  final IconData icon;
  final Color primaryColor;
  final Color backgroundColor;

  ActivitySummary({
    required this.title,
    required this.count,
    required this.lastTime,
    required this.icon,
    required this.primaryColor,
    required this.backgroundColor,
  });
}