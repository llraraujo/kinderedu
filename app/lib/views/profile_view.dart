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
  late ChildProfile _profile;

  @override
  void initState() {
    super.initState();
    _profile = _controller.getChildProfile();
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
                  _buildIdentityCard(), // Card da Maria Silva
                  const SizedBox(height: 20),
                  _buildMenuSection('Conta', _controller.getAccountOptions()),
                  const SizedBox(height: 20),
                  _buildMenuSection('Emergência', _controller.getEmergencyOptions()),
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



  Widget _buildIdentityCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 25, backgroundImage: NetworkImage('https://via.placeholder.com/150')),
          const SizedBox(width: 15),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Maria Silva', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text('Responsável', style: TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }
}