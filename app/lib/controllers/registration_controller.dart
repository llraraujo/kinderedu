import 'package:flutter/material.dart';
import '../models/registration_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegistrationController {
  // Estado da categoria selecionada
  ETipoAtividade tipoSelecionado = ETipoAtividade.ALIMENTACAO;
  final String baseURL = "http://localhost:8080";

  // Controladores de texto para capturar os inputs
  final TextEditingController foodController = TextEditingController();
  final TextEditingController hygieneController = TextEditingController();

  // Estados específicos para o registro de sono
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  // Altera a categoria ativa e notifica a View para remontar o layout
  void changeCategory(ETipoAtividade tipo, VoidCallback updateUI) {
    tipoSelecionado = tipo;
    updateUI();
  }

  // Processa o salvamento com base na categoria ativa
  Future<bool> saveRegistration(String studentId) async {
    RegistrationModel registro;

    switch (tipoSelecionado) {
      case ETipoAtividade.ALIMENTACAO:
        if (foodController.text.trim().isEmpty) return false;
        // Integração futura com repositório/Firebase aqui
        registro = RegistrationModel(alunoId: int.parse(studentId), tipo:ETipoAtividade.ALIMENTACAO, observacao: foodController.text);
        foodController.clear();
        break;

      case ETipoAtividade.SONECA:
        if (startTime == null || endTime == null) return false;
        // Processamento dos horários do sono
        registro = RegistrationModel(alunoId: int.parse(studentId), tipo:ETipoAtividade.SONECA, inicioSoneca: startTime.toString(), fimSoneca: endTime.toString());
        startTime = null;
        endTime = null;
        break;

      case ETipoAtividade.HIGIENE:
        if (hygieneController.text.trim().isEmpty) return false;
        registro = RegistrationModel(alunoId: int.parse(studentId), tipo:ETipoAtividade.HIGIENE, observacao: hygieneController.text);
        // Processamento do texto de higiene
        hygieneController.clear();
        break;
    }

    return await createAtividade(studentId, registro);
  }

  Future<bool> createAtividade(String alunoId, RegistrationModel registro) async {
  final url = Uri.parse('$baseURL/alunos/$alunoId/atividade');
  
  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(registro, toEncodable: (Object? value) => value is RegistrationModel ? RegistrationModel.toJson(value) :  throw UnsupportedError("erro ao transformar para um JSON object")),
    );

    if (response.statusCode == 201) {
      print('Atividade criada com sucesso: ${response.body}');
      return true;
    } else {
      print('falta ao registrar a atividade.');
    }
  } catch (e) {
    print('Error: $e');
  }
  return false;
}
  
  void dispose() {
    foodController.dispose();
    hygieneController.dispose();
  }
}