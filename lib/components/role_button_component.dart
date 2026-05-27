/// Componente customizado para o botão de seleção de perfil
  import 'package:flutter/material.dart';
  

  /// Componente customizado para o botão de seleção de perfil
  Widget roleButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final Color primaryColor = const Color(0xFF5654A2); // Roxo/Azul do botão
    final Color greyBackground = const Color(0xFFF4F6F9); //
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? primaryColor : greyBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }