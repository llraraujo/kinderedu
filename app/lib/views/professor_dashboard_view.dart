import 'package:flutter/material.dart';
import 'package:kinderedu/models/login_model.dart';
import 'package:kinderedu/views/login_view.dart';
import 'package:kinderedu/views/registration_view.dart';
import '../controllers/professor_dashboard_controller.dart';
import '../models/professor_dashboard_model.dart';

class ProfessorDashboardView extends StatefulWidget {
  const ProfessorDashboardView({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<ProfessorDashboardView> createState() => _ProfessorDashboardViewState();
}

class _ProfessorDashboardViewState extends State<ProfessorDashboardView> {
  final EducatorDashboardController _controller = EducatorDashboardController();
  
  late ProfessorProfile _profile;
  late List<StudentOverview> _students;

  @override
  void initState() {
    super.initState();
    _profile = _controller.getProfessorProfile();
    _students = _controller.getClassStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE), // Fundo padrão do app
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 30),
              _buildClassHeader(),
              const SizedBox(height: 15),
              _buildStudentsList(),
            ],
          ),
        ),
      ),
    );
  }

  // Cabeçalho da Professora
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo Kinder Edu (Placeholder)
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: const Center(
                child: Icon(Icons.menu_book, color: Colors.grey, size: 30),
              ),
            ),
            // Botão de Sair
            IconButton(
              icon: const Icon(Icons.logout_outlined, color: Color(0xFF2D3142)),
              onPressed: () {
                // Lógica de logout
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Olá, ${_profile.name}!',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
        ),
        const SizedBox(height: 4),
        Text(
          '${_profile.className} • ${_profile.studentCount} crianças',
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
      ],
    );
  }

  // Título da seção da lista
  Widget _buildClassHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'Minha Turma',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
        ),
        Text(
          '${_profile.studentCount} alunos',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }

  // Lista de alunos
  Widget _buildStudentsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _students.length,
      itemBuilder: (context, index) {
        final student = _students[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Linha 1: Info da Criança
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(student.imageUrl),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.name,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          student.age,
                          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                        ),
                        Text(
                          'Resp: ${student.responsibleName}',
                          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // Linha 2: Botões de Ação
              Row(
                children: [
                  _buildActionButton(
                    label: 'Registrar',
                    icon: Icons.add,
                    color: const Color(0xFF5A45FF), // Roxo/Azul
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  RegistrationView(studentId: student.id, studentName: student.name,)));
                    },
                  ),
                  const SizedBox(width: 8),
                  _buildActionButton(
                    label: 'Foto',
                    icon: Icons.camera_alt_outlined,
                    color: const Color(0xFFB042FF), // Rosa/Roxo claro
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  _buildActionButton(
                    label: 'Ficha',
                    icon: Icons.description_outlined,
                    color: const Color(0xFF00C4A7), // Verde/Teal
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Widget customizado para os botões de ação
  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 16),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}