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

class ActivityFromDb{
  final String tipoAtividade;
  final int quantidade;
  final DateTime ultimaAtualizacao;

  ActivityFromDb({
    required this.tipoAtividade,
    required this.quantidade, 
    required this.ultimaAtualizacao
  });


  ActivityFromDb.fromJson(Map<String, dynamic> json):
  tipoAtividade = json["tipoAtividade"], 
  quantidade = json["quantidade"], 
  ultimaAtualizacao = DateTime.parse(json["ultimaAtualizacao"]);


}