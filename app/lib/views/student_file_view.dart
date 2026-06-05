import 'package:flutter/material.dart';
import '../controllers/student_file_controller.dart';
import '../models/student_file_model.dart';

class StudentFileView extends StatefulWidget {
  final String studentId;
  final String studentName;
  
  const StudentFileView({Key? key, required this.studentId, required this.studentName}) : super(key: key);

  @override
  State<StudentFileView> createState() => _StudentFileViewState();
}

class _StudentFileViewState extends State<StudentFileView> {
  final StudentFileController _controller = StudentFileController();
  late StudentFileModel _fileData;

  @override
  void initState() {
    super.initState();
    _fileData = _controller.getStudentFile(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Seção Responsável
            _buildFileCard(
              title: 'Responsável',
              icon: Icons.person_outline,
              iconColor: const Color(0xFF7B3AED),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabelValue('Nome', _fileData.responsible.name),
                  const SizedBox(height: 12),
                  _buildLabelValue('Telefone', _fileData.responsible.phone, isPhone: true),
                ],
              ),
            ),
            
            // Seção Emergência
            _buildFileCard(
              title: 'Contatos de Emergência',
              icon: Icons.error_outline,
              iconColor: const Color(0xFFF97316),
              content: Column(
                children: _fileData.emergencyContacts.map((contact) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(contact.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        Text(contact.relation, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.phone_outlined, size: 14, color: Colors.grey),
                            const SizedBox(width: 5),
                            Text(contact.phone, style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            // Seção Saúde
            _buildFileCard(
              title: 'Ficha de Saúde',
              icon: Icons.favorite_border,
              iconColor: const Color(0xFFEC4899),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabelValue('Alergias', _fileData.healthInfo.allergies),
                  const SizedBox(height: 12),
                  _buildLabelValue('Medicação', _fileData.healthInfo.medications),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF2D3142)),
        onPressed: () => Navigator.pop(context),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Ficha do Aluno', style: TextStyle(color: Color(0xFF2D3142), fontSize: 18, fontWeight: FontWeight.bold)),
          Text(widget.studentName, style: TextStyle(color: Colors.grey[600], fontSize: 14, fontWeight: FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildFileCard({required String title, required IconData icon, required Color iconColor, required Widget content}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 22),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2D3142))),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Divider(height: 1, color: Color(0xFFF1F1F1)),
          ),
          content,
        ],
      ),
    );
  }

  Widget _buildLabelValue(String label, String value, {bool isPhone = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 2),
        Row(
          children: [
            if (isPhone) const Padding(padding: EdgeInsets.only(right: 5), child: Icon(Icons.phone_outlined, size: 14, color: Colors.grey)),
            Expanded(child: Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color(0xFF2D3142)))),
          ],
        ),
      ],
    );
  }
}