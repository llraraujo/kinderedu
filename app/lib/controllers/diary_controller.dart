import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kinderedu/models/diary_model.dart';
import 'package:kinderedu/models/header_model.dart';
import 'package:kinderedu/services/api_config.dart';

class DiaryController {
  final String baseURL = ApiConfig.baseUrl;

  ChildProfile getChildProfile() {
    return childProfileHeader;
  }

  Future<ChildProfile> getChildProfileFromDb(String cpfResponsavel) async {
    final url = Uri.parse("$baseURL/alunos/$cpfResponsavel");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body) as Map<String, dynamic>;
        return ChildProfile.fromJson(decoded);
      }
    } catch (e) {
      print("Erro ao recuperar o perfil da crianca: $e");
    }

    return childProfileHeader;
  }

  List<DiaryEntry> getAvailableYears() {
    final currentYear = DateTime.now().year;
    return [
      DiaryEntry(
        year: currentYear,
        icon: Icons.calendar_month_outlined,
        iconColor: Colors.indigo,
      ),
      DiaryEntry(
        year: currentYear - 1,
        icon: Icons.calendar_month_outlined,
        iconColor: Colors.indigo,
      ),
    ];
  }

  List<DiaryMonth> getAvailableMonths(int year) {
    return const [
      "Janeiro",
      "Fevereiro",
      "Marco",
      "Abril",
      "Maio",
      "Junho",
      "Julho",
      "Agosto",
      "Setembro",
      "Outubro",
      "Novembro",
      "Dezembro",
    ].map((month) {
      return DiaryMonth(
        month: month,
        icon: Icons.calendar_month_outlined,
        iconColor: Colors.purpleAccent,
      );
    }).toList();
  }

  List<DiaryDayEntry> getDaysForMonth(String month, int year) {
    final monthNumber = monthNumberFromName(month);
    final daysInMonth = DateUtils.getDaysInMonth(year, monthNumber);

    return List.generate(
      daysInMonth,
      (index) => daysInMonth - index,
    ).map((day) => DiaryDayEntry(day: day, month: month, year: year)).toList();
  }

  Future<List<DayActivity>> getActivitiesForDayFromDb({
    required int alunoId,
    required String cpfResponsavel,
    required DateTime date,
  }) async {
    final formattedDate = date.toIso8601String().split('T').first;
    final url = Uri.parse('$baseURL/alunos/$alunoId/atividades').replace(
      queryParameters: {
        'cpfResponsavel': cpfResponsavel,
        'data': formattedDate,
      },
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body) as List<dynamic>;
        return decoded
            .map((value) => DayActivity.fromJson(value as Map<String, dynamic>))
            .toList();
      }
      print('Erro ao recuperar atividades: ${response.statusCode}');
    } catch (e) {
      print('Erro ao recuperar atividades: $e');
    }

    return [];
  }

  int monthNumberFromName(String month) {
    switch (month.trim().toUpperCase()) {
      case "JANEIRO":
        return 1;
      case "FEVEREIRO":
        return 2;
      case "MARCO":
        return 3;
      case "ABRIL":
        return 4;
      case "MAIO":
        return 5;
      case "JUNHO":
        return 6;
      case "JULHO":
        return 7;
      case "AGOSTO":
        return 8;
      case "SETEMBRO":
        return 9;
      case "OUTUBRO":
        return 10;
      case "NOVEMBRO":
        return 11;
      case "DEZEMBRO":
        return 12;
      default:
        return DateTime.now().month;
    }
  }

  String monthNameFromNumber(int month) {
    const months = [
      "",
      "Janeiro",
      "Fevereiro",
      "Marco",
      "Abril",
      "Maio",
      "Junho",
      "Julho",
      "Agosto",
      "Setembro",
      "Outubro",
      "Novembro",
      "Dezembro",
    ];
    return months[month];
  }
}
