import 'package:kinderedu/models/login_model.dart';
import 'package:http/http.dart' as http;
import 'package:kinderedu/services/api_config.dart';
import 'dart:convert';

class LoginController {

  final String baseURL = ApiConfig.baseUrl;


  Future<List<User>> getUsers(String username) async{
    List<User> users = [];
    final url = Uri.parse("$baseURL/users/$username");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body) as List<dynamic>;
         return decoded
            .map((value) => User.fromJson(value as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      print("Erro ao recuperar consultar o usuário: $e");
    }
    return users;
  }

// Fazer chamada na API para retornar os usuários cadastrados
  List<User> getUsuariosCadastrados(){
    return [
      User(username: "11111111111", password: "teste123", role: "RESPONSAVEL"),
      User(username: "22222222222", password: "teste123", role: "PROFESSOR"),
    ];
  }
}
