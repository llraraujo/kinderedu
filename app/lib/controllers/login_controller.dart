import 'package:kinderedu/models/login_model.dart';

class LoginController {

// Fazer chamada na API para retornar os usuários cadastrados
  List<User> getUsuariosCadastrados(){
    return [
      User(cpf: "111.111.111-11", senha: "teste123"),
      User(cpf: "222.222.222-22", senha: "teste456"),
    ];
  }
}
