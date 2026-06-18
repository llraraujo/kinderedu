import 'package:kinderedu/models/login_model.dart';

class LoginController {

// Fazer chamada na API para retornar os usuários cadastrados
  List<User> getUsuariosCadastrados(){
    return [
      User(cpf: "11111111111", senha: "teste123", role: "RESPONSAVEL"),
      User(cpf: "22222222222", senha: "teste123", role: "PROFESSOR"),
    ];
  }
}
