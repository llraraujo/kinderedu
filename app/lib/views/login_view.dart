import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:kinderedu/components/role_button_component.dart';
import 'package:kinderedu/controllers/login_controller.dart';
import 'package:kinderedu/models/login_model.dart';
import 'package:kinderedu/views/main_view.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controle de estado
  final LoginController _controller = LoginController();
  final TextEditingController _cpf = TextEditingController();
  final TextEditingController _senha = TextEditingController();
  final maskCpf = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});
  bool isEducador = true; // Define qual aba está selecionada
  bool obscurePassword = true;
  bool rememberMe = false;
  String _msgExisteUsuario = "";

   @override
   void initState() {
    super.initState();
  }

  void _limparCampos() {
    setState(() {   
       _cpf.text = "";
       _senha.text = "";
       _msgExisteUsuario = "";
    });
  }

  // Cores principais baseadas na imagem
  final Color primaryColor = const Color(0xFF5654A2); // Roxo/Azul do botão
  final Color greyBackground = const Color(0xFFF4F6F9); // Cinza claro

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              
              // 1. Logo (Usando um ícone como placeholder para a imagem do livro)
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black87, width: 1.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Icon(Icons.auto_stories_outlined, size: 40),
                      const SizedBox(height: 8),
                      const Text(
                        'KINDER EDU',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // 2. Textos de Boas-vindas
              const Text(
                'Bem-vindo de volta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1C29),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Entre com suas credenciais para continuar',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 32),

              // 3. Toggle Responsável / Educador
              Row(
                children: [
                  roleButton(
                    title: 'Responsável',
                    isSelected: !isEducador,
                    onTap: () => setState(() => isEducador = false),
                  ),
                  const SizedBox(width: 12),
                  roleButton(
                    title: 'Educador',
                    isSelected: isEducador,
                    onTap: () => setState(() => isEducador = true),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // 4. Campo de CPF (Label dinâmico)
              TextField(
                inputFormatters: [maskCpf],
                decoration: InputDecoration(
                label: Text(isEducador ? 'CPF do educador' : 'CPF do Responsável'),
                hintText: '000.000.000-00',
                prefixIcon: Icon(Icons.person_outline)
                ),
                controller: _cpf,
                keyboardType: TextInputType.number,
                
              ),
              const SizedBox(height: 20),

              // 5. Campo de Senha
              TextField(
                controller: _senha,
                obscureText: obscurePassword,
                decoration: InputDecoration(
                label: Text('Senha'),
                hintText: '••••••••',
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () => setState(() => obscurePassword = !obscurePassword),
                ),
                )
            
                
              ),
              const SizedBox(height: 12),

              // 6. Lembrar-me e Esqueci a senha
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() => rememberMe = value ?? false);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Lembrar-me',
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Ação de esqueci a senha
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Esqueceu a senha?',
                      style: TextStyle(color: primaryColor, fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // 7. Botão Entrar
              ElevatedButton(
                onPressed: () {
                  var user = _controller.getUsuariosCadastrados().firstWhere(
                    (user) => user.cpf == _cpf.text && user.senha == _senha.text,
                    orElse: () =>  User(cpf:"",senha:"")
                  );
                  if(user.cpf.isNotEmpty && user.senha.isNotEmpty){
                    _limparCampos();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MainView()));
                    return;
                  }
                  setState(() {
                     _msgExisteUsuario = "usuário/senha não existe na base de dados.";
                  });                 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Entrar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                _msgExisteUsuario,
                style: const TextStyle(color: Colors.red),
            ),
            ],
          ),
        ),
      ),
    );
  }
}