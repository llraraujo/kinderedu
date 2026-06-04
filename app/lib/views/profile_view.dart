import 'package:flutter/material.dart';
import 'package:kinderedu/components/header_component.dart';
import 'package:kinderedu/models/header_model.dart';
import 'package:kinderedu/views/login_view.dart';
import '../controllers/profile_controller.dart';
import '../models/profile_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileController _controller = ProfileController();
  late List<EmergencyContact> _emergencyContacts;
  late ChildProfile _profile;
  late UserProfile _userProfile;

  @override
  void initState() {
    super.initState();
    _profile = _controller.getChildProfile();
    _emergencyContacts = _controller.getEmergencyContacts();
    _userProfile = _controller.getUserProfile();
  }

  List<ProfileMenuOption> _getAccountOptions() {
    return [
      ProfileMenuOption(
        title: 'Editar Perfil', 
        icon: Icons.person_outline, 
        color: Colors.blue, 
        onTap: () => _showEditProfileDialog(context), // Chamada inserida aqui
      )
    ];
  }

  List<ProfileMenuOption> _getEmergencyOptions() {
    return [
      ProfileMenuOption(
        title: 'Contatos de Emergência', 
        icon: Icons.favorite_border, 
        color: Colors.purple, 
        onTap: () => _showEmergencyContactsDialog(context)
      ),
      ProfileMenuOption(
        title: 'Informações de Saúde', 
        icon: Icons.medical_services_outlined, 
        color: Colors.purple, 
        onTap: () => _showHealthInfoDialog(context), // Chamada do novo dialog!
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: Column(
        children: [
          header(_profile), // Cabeçalho roxo (Ana Clara)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  _buildMenuSection('Conta', _getAccountOptions()),
                  const SizedBox(height: 20),
                  _buildMenuSection('Emergência', _getEmergencyOptions()),
                  const SizedBox(height: 20),
                  _buildMenuSection('Segurança', _controller.getSecurityOptions()),
                  const SizedBox(height: 30),
                  _buildLogoutButton(),
                  const SizedBox(height: 15),
                  const Text('Kinder Edu v1.0.0', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Seção de Menu Agrupada
  Widget _buildMenuSection(String sectionTitle, List<ProfileMenuOption> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, bottom: 8),
          child: Text(
            sectionTitle,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
          ),
          child: Column(
            children: options.asMap().entries.map((entry) {
              int idx = entry.key;
              ProfileMenuOption opt = entry.value;
              return Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: opt.color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                      child: Icon(opt.icon, color: opt.color, size: 20),
                    ),
                    title: Text(opt.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                    onTap: opt.onTap,
                  ),
                  if (idx != options.length - 1) // Divisor entre itens, menos no último
                    const Divider(height: 1, indent: 60, endIndent: 20, color: Color(0xFFF1F1F1)),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return TextButton.icon(
      onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.redAccent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.redAccent.withOpacity(0.2)),
        ),
      ),
      icon: const Icon(Icons.logout_rounded, size: 20),
      label: const Text('Sair da Conta', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  void _showEditProfileDialog(BuildContext context) {
    // Controladores locais para gerenciar os inputs de texto
    final TextEditingController nameController = TextEditingController(text: _userProfile.name);
    final TextEditingController cpfController = TextEditingController(text: _userProfile.cpf);
    final TextEditingController emailController = TextEditingController(text: _userProfile.email);
    final TextEditingController phoneController = TextEditingController(text: _userProfile.phone);

    showDialog(
      context: context,
      barrierDismissible: false, // Evita fechar tocando fora se houver dados não salvos
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Editar Perfil',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
          ),
          // SingleChildScrollView evita o erro de overflow quando o teclado virtual sobe
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDialogTextField('Nome', nameController),
                const SizedBox(height: 15),
                _buildDialogTextField('CPF', cpfController),
                const SizedBox(height: 15),
                _buildDialogTextField('E-mail', emailController),
                const SizedBox(height: 15),
                _buildDialogTextField('Telefone', phoneController),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Cancelar', style: TextStyle(color: Colors.black54)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // 1. Envia os dados atualizados para o Controller
                      _controller.updateUserProfile(
                        name: nameController.text,
                        cpf: cpfController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                      );
                      
                      // 2. Opcional: Atualizar o estado local da View se necessário
                      // setState(() { _userProfile = novoPerfil; });

                      // 3. Fecha o dialog
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A45FF), // Cor roxa baseada no design
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Salvar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showHealthInfoDialog(BuildContext context) {
    // Obtendo os dados via Controller (idealmente carregados no initState)
    final healthInfo = _controller.getChildHealthInfo();
    
    final TextEditingController allergiesController = TextEditingController(text: healthInfo.allergies);
    final TextEditingController medicationsController = TextEditingController(text: healthInfo.medications);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            'Ficha de Saúde',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMultilineTextField('Alergias', allergiesController, isRequired: true),
                const SizedBox(height: 15),
                _buildMultilineTextField('Medicação', medicationsController, isRequired: true),
                const SizedBox(height: 20),
                _buildWarningBox(), // Caixa de alerta amarela
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Cancelar', style: TextStyle(color: Colors.black54)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _controller.updateChildHealthInfo(
                        allergies: allergiesController.text,
                        medications: medicationsController.text,
                      );
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A45FF),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Salvar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
  // Widget auxiliar para padronizar os campos de texto do formulário
  
  // Campo de texto expansível (Multiline) com suporte a asterisco vermelho
  Widget _buildMultilineTextField(String label, TextEditingController controller, {bool isRequired = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF2D3142), fontWeight: FontWeight.w500),
            children: [
              if (isRequired)
                const TextSpan(text: ' *', style: TextStyle(color: Colors.redAccent)),
            ],
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: 3, // Altura baseada no protótipo (permite quebras de linha)
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF5A45FF)),
            ),
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  // Caixa de alerta amarela
  Widget _buildWarningBox() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBE6), // Fundo amarelo bem claro
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFFD666)), // Borda dourada/amarela
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFD97706), size: 20), // Ícone em tom de âmbar
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Mantenha estas informações sempre atualizadas. Elas são essenciais para a segurança da criança.',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF92400E), // Texto escuro em tom terroso para garantir acessibilidade/leitura
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: Color(0xFF2D3142), fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF5A45FF)),
            ),
          ),
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }


// --- MODAL 1: LISTA DE CONTATOS DE EMERGÊNCIA ---
  void _showEmergencyContactsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // O StatefulBuilder permite atualizar a interface APENAS dentro do Modal
        return StatefulBuilder(
          builder: (context, setModalState) {
            // Busca a lista atualizada
            final contacts = _controller.getEmergencyContacts();

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              contentPadding: const EdgeInsets.all(20),
              title: const Text(
                'Contatos de Emergência',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Lista de Contatos
                    ...contacts.map((contact) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA), // Fundo cinza bem leve
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    contact.name,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF2D3142)),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    contact.phone,
                                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                            // Botão de Remover
                            InkWell(
                              onTap: () {
                                // 1. Atualiza o estado do Modal
                                setModalState(() {
                                  _controller.removeEmergencyContact(contact);
                                });
                                // 2. Atualiza a View de Perfil (tela de fundo)
                                setState(() {
                                  _emergencyContacts = _controller.getEmergencyContacts();
                                });
                              },
                              child: const Text(
                                'Remover',
                                style: TextStyle(color: Colors.redAccent, fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    
                    const SizedBox(height: 10),

                    // Botão Primário: Adicionar Contato
                    ElevatedButton(
                      onPressed: () {
                        // Abre o segundo modal e aguarda o retorno para atualizar a lista
                        _showAddContactDialog(context, onContactAdded: () {
                          setModalState(() {}); // Atualiza este modal
                          setState(() { // Atualiza a tela de perfil ao fundo
                            _emergencyContacts = _controller.getEmergencyContacts();
                          });
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5A45FF), // Roxo
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('+ Adicionar Contato', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 10),
                    
                    // Botão Secundário: Fechar
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey[100],
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Fechar', style: TextStyle(color: Colors.black54)),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // --- MODAL 2: ADICIONAR NOVO CONTATO ---
  void _showAddContactDialog(BuildContext parentContext, {required VoidCallback onContactAdded}) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text(
            'Novo Contato',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogTextField('Nome', nameController),
              const SizedBox(height: 15),
              _buildDialogTextField('Telefone', phoneController),
            ],
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[100],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Cancelar', style: TextStyle(color: Colors.black54)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty && phoneController.text.isNotEmpty) {
                        // Adiciona no controller
                        _controller.addEmergencyContact(nameController.text, phoneController.text);
                        // Aciona a callback para reconstruir o Modal 1
                        onContactAdded();
                        // Fecha o Modal 2
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A45FF),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Salvar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}