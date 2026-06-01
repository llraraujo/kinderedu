import 'package:flutter/material.dart';



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