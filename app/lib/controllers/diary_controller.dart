import 'package:flutter/material.dart';
import 'package:kinderedu/models/diary_model.dart';
import 'package:kinderedu/models/header_model.dart';

class DiaryController {
   ChildProfile getChildProfile() {
    return childProfileHeader;
  }

  List<DiaryEntry> getAvailableYears() {
    return [
      DiaryEntry(
        year: 2025,
        icon: Icons.calendar_month_outlined,
        iconColor: Colors.indigo,
      ),
      DiaryEntry(
        year: 2024,
        icon: Icons.calendar_month_outlined,
        iconColor: Colors.indigo,
      ),
    ];
  }

  List<DiaryMonth>? getAvailableMonths(int year) {
    Map<int, List<DiaryMonth>> yearMonths = {
      2025: [
      DiaryMonth(
        month: "Novembro",
        icon: Icons.calendar_month_outlined,
        iconColor: Colors.purpleAccent,
      ),
      DiaryMonth(
        month: "Outubro",
        icon: Icons.calendar_month_outlined,
        iconColor: Colors.purpleAccent,
      )],

      2024: [
      DiaryMonth(
        month: "Janeiro",
        icon: Icons.calendar_month_outlined,
        iconColor: Colors.purpleAccent,
      ),
      DiaryMonth(
        month: "Fevereiro",
        icon: Icons.calendar_month_outlined,
        iconColor: Colors.purpleAccent,
      )]
    };

    return yearMonths[year];
  }

  List<DiaryDayEntry> getDaysForMonth(String month, int year) {
    
    return List.generate(12, (index) => 27 - index).map((day) {
      return DiaryDayEntry(day: day, month: month, year: year);
    }).toList();
  }

  List<DayActivity> getActivitiesForDay(DateTime date) {
    // Simulação dos dados vindos da API
    return [
      DayActivity(
        title: 'Refeição',
        description: 'comeu fruta toda',
        time: '14:30',
        icon: Icons.restaurant,
        color: Colors.orange,
      ),
      DayActivity(
        title: 'Soneca da Tarde',
        description: '13:00 – 13:45',
        time: '13:00',
        icon: Icons.nightlight_round,
        color: Colors.purple,
      ),
      DayActivity(
        title: 'Refeição',
        description: 'papinha de legumes',
        time: '12:00',
        icon: Icons.restaurant,
        color: Colors.orange,
      ),
      DayActivity(
        title: 'Higiene',
        description: 'trocou fralda',
        time: '11:30',
        icon: Icons.child_care,
        color: Colors.green,
      ),
      DayActivity(
        title: 'Soneca da Manhã',
        description: '09:00 – 10:00',
        time: '09:00',
        icon: Icons.nightlight_round,
        color: Colors.purple,
      ),
      DayActivity(
        title: 'Higiene',
        description: 'trocou fralda',
        time: '08:30',
        icon: Icons.child_care,
        color: Colors.green,
      ),
    ];
  }
}