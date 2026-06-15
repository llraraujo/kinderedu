import 'package:flutter/material.dart';
import 'package:kinderedu/models/header_model.dart';
import '../models/dashboard_model.dart'; // Ajuste o import conforme sua estrutura
import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardController {
  // Simula a busca de dados do perfil da criança

  final String baseURL = "http://localhost:8080";

  
  ChildProfile getChildProfile() {
    return childProfileHeader;
  }

  Future<ChildProfile> getChildProfileFromDb(String cpfResponsavel) async{
    final url = Uri.parse("$baseURL/alunos/$cpfResponsavel");
    ChildProfile childProfile = childProfileHeader;
    try{
       final response = await http.get(url);
        if(response.statusCode == 200){
          var decoded = jsonDecode(response.body, reviver: (key, value) => value is Map<String, dynamic> ? ChildProfile.fromJson(value) : value);
           print(decoded.toString());
           return decoded as ChildProfile;
        }
        else{
          print("Erro ao recuper o sumário de atividades");
        }
    }catch(e){
      print("Erro ao recuper o perfil da criança");
    }
    return childProfile;
  }

  Future<List<ActivitySummary>>  getAtivdades(int studentId) async{
    final url = Uri.parse("$baseURL/alunos/atividades/$studentId");
    List<ActivitySummary> atividades = [];
    try{
        final response = await http.get(url);
        if(response.statusCode == 200){
          var decoded = jsonDecode(response.body, reviver: (key, value) => value is Map<String, dynamic> ? ActivityFromDb.fromJson(value) : value);
          var atividadesDb = List<ActivityFromDb>.from(decoded);
          atividades = convertActivityFromDbToSummary(atividadesDb);
          return atividades;
        }
        else{
          print("Erro ao recuper o sumário de atividades");
        }
    }catch(e){
      print('Connection Error: $e');
    }

    return atividades;

  }

   List<ActivitySummary> convertActivityFromDbToSummary(List<ActivityFromDb> activities){
      List<ActivitySummary> summary = [];
      for(var activity in activities){
        switch(activity.tipoAtividade){

          case "SONECA":
          summary.add(ActivitySummary(
                    title: "Sonecas", 
                    count: activity.quantidade, 
                    lastTime: activity.horaUltimaAtividade, 
                    icon: Icons.nightlight_round, 
                    primaryColor: Colors.purpleAccent,
                    backgroundColor: Colors.purple.withOpacity(0.1)));
          break;

          case "ALIMENTACAO":
          summary.add(ActivitySummary(
                    title: "Alimentação", 
                    count: activity.quantidade, 
                    lastTime: activity.horaUltimaAtividade, 
                    icon: Icons.restaurant, 
                    primaryColor: Colors.orange,
                    backgroundColor: Colors.orange.withOpacity(0.1)));
          break;

          case "HIGIENE":
           summary.add(ActivitySummary(
                    title: "Higiene", 
                    count: activity.quantidade, 
                    lastTime: activity.horaUltimaAtividade, 
                    icon: Icons.child_care, 
                    primaryColor: Colors.green,
                    backgroundColor: Colors.green.withOpacity(0.1)));
          break;
        }
      }

      return summary;
   }

  // Simula a busca das atividades do dia
  List<ActivitySummary> getTodayActivities() {
    return [
      ActivitySummary(
        title: 'Sonecas',
        count: 2,
        lastTime: '13:00',
        icon: Icons.nightlight_round,
        primaryColor: Colors.purpleAccent,
        backgroundColor: Colors.purple.withOpacity(0.1),
      ),
      ActivitySummary(
        title: 'Higiene',
        count: 5,
        lastTime: '11:30',
        icon: Icons.child_care,
        primaryColor: Colors.green,
        backgroundColor: Colors.green.withOpacity(0.1),
      ),
      ActivitySummary(
        title: 'Alimentação',
        count: 2,
        lastTime: '12:00',
        icon: Icons.restaurant,
        primaryColor: Colors.orange,
        backgroundColor: Colors.orange.withOpacity(0.1),
      ),
    ];
  }
}