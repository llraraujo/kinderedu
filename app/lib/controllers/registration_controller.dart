import 'package:flutter/material.dart';
import '../models/registration_model.dart';

class RegistrationController {
  // Estado da categoria selecionada
  RegisterCategory currentCategory = RegisterCategory.food;

  // Controladores de texto para capturar os inputs
  final TextEditingController foodController = TextEditingController();
  final TextEditingController hygieneController = TextEditingController();

  // Estados específicos para o registro de sono
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  // Altera a categoria ativa e notifica a View para remontar o layout
  void changeCategory(RegisterCategory category, VoidCallback updateUI) {
    currentCategory = category;
    updateUI();
  }

  // Processa o salvamento com base na categoria ativa
  bool saveRegistration(String studentId) {
    switch (currentCategory) {
      case RegisterCategory.food:
        if (foodController.text.trim().isEmpty) return false;
        // Integração futura com repositório/Firebase aqui
        foodController.clear();
        break;

      case RegisterCategory.sleep:
        if (startTime == null || endTime == null) return false;
        // Processamento dos horários do sono
        startTime = null;
        endTime = null;
        break;

      case RegisterCategory.hygiene:
        if (hygieneController.text.trim().isEmpty) return false;
        // Processamento do texto de higiene
        hygieneController.clear();
        break;
    }
    return true;
  }
  
  void dispose() {
    foodController.dispose();
    hygieneController.dispose();
  }
}