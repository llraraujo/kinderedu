import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kinderedu/services/api_config.dart';

import '../models/registration_model.dart';

class RegistrationController {
  ETipoAtividade tipoSelecionado = ETipoAtividade.ALIMENTACAO;
  final String baseURL = ApiConfig.baseUrl;

  final TextEditingController foodController = TextEditingController();
  final TextEditingController hygieneController = TextEditingController();

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  void changeCategory(ETipoAtividade tipo, VoidCallback updateUI) {
    tipoSelecionado = tipo;
    updateUI();
  }

  Future<bool> saveRegistration(String studentId, String professorCpf) async {
    RegistrationModel registro;

    switch (tipoSelecionado) {
      case ETipoAtividade.ALIMENTACAO:
        if (foodController.text.trim().isEmpty) return false;
        registro = RegistrationModel(
          alunoId: int.parse(studentId),
          tipo: ETipoAtividade.ALIMENTACAO,
          observacao: foodController.text.trim(),
        );
        break;

      case ETipoAtividade.SONECA:
        if (startTime == null || endTime == null) return false;
        registro = RegistrationModel(
          alunoId: int.parse(studentId),
          tipo: ETipoAtividade.SONECA,
          inicioSoneca: _formatTime(startTime!),
          fimSoneca: _formatTime(endTime!),
        );
        break;

      case ETipoAtividade.HIGIENE:
        if (hygieneController.text.trim().isEmpty) return false;
        registro = RegistrationModel(
          alunoId: int.parse(studentId),
          tipo: ETipoAtividade.HIGIENE,
          observacao: hygieneController.text.trim(),
        );
        break;
    }

    final success = await createAtividade(studentId, professorCpf, registro);
    if (success) {
      _clearCurrentForm();
    }
    return success;
  }

  Future<bool> createAtividade(
    String alunoId,
    String professorCpf,
    RegistrationModel registro,
  ) async {
    final url = Uri.parse(
      '$baseURL/alunos/$alunoId/atividade',
    ).replace(queryParameters: {'cpfProfessor': professorCpf});

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(
          registro,
          toEncodable: (Object? value) => value is RegistrationModel
              ? RegistrationModel.toJson(value)
              : throw UnsupportedError(
                  "erro ao transformar para um JSON object",
                ),
        ),
      );

      if (response.statusCode == 201) {
        print('Atividade criada com sucesso: ${response.body}');
        return true;
      } else {
        print('falha ao registrar a atividade.');
      }
    } catch (e) {
      print('Error: $e');
    }
    return false;
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void dispose() {
    foodController.dispose();
    hygieneController.dispose();
  }

  void _clearCurrentForm() {
    switch (tipoSelecionado) {
      case ETipoAtividade.ALIMENTACAO:
        foodController.clear();
        break;
      case ETipoAtividade.SONECA:
        startTime = null;
        endTime = null;
        break;
      case ETipoAtividade.HIGIENE:
        hygieneController.clear();
        break;
    }
  }
}
