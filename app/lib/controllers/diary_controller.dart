import 'package:flutter/material.dart';
import 'package:kinderedu/models/header_model.dart';
import '../models/diary_model.dart';

class DiaryController {
   ChildProfile getChildProfile() {
    return childProfileHeader;
  }

  List<DiaryEntry> getAvailableYears() {
    return [
      DiaryEntry(
        year: '2025',
        icon: Icons.calendar_month_outlined,
        iconColor: Colors.indigo,
      ),
      DiaryEntry(
        year: '2024',
        icon: Icons.calendar_month_outlined,
        iconColor: Colors.indigo,
      ),
    ];
  }
}