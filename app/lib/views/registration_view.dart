import 'package:flutter/material.dart';
import '../controllers/registration_controller.dart';
import '../models/registration_model.dart';

class RegistrationView extends StatefulWidget {
  final String studentName;
  final String studentId;
  final String professorCpf;

  const RegistrationView({
    Key? key,
    required this.studentName,
    required this.studentId,
    required this.professorCpf,
  }) : super(key: key);

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final RegistrationController _controller = RegistrationController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: Text('Registrar Rotina - ${widget.studentName}'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2D3142),
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildCategoryTabs(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: _buildCategoryBody(),
            ),
          ),
        ],
      ),
    );
  }

  // Renderiza as três abas superiores com suas respectivas identidades visuais
  Widget _buildCategoryTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTabItem(
          tipo: ETipoAtividade.ALIMENTACAO,
          label: 'Alimentação',
          icon: Icons.restaurant,
          activeColor: Colors.orange,
        ),
        _buildTabItem(
          tipo: ETipoAtividade.SONECA,
          label: 'Sono',
          icon: Icons.nightlight_round,
          activeColor: Colors.purple,
        ),
        _buildTabItem(
          tipo: ETipoAtividade.HIGIENE,
          label: 'Higiene',
          icon: Icons.child_care,
          activeColor: Colors.green,
        ),
      ],
    );
  }

  Widget _buildTabItem({
    required ETipoAtividade tipo,
    required String label,
    required IconData icon,
    required Color activeColor,
  }) {
    final bool isActive = _controller.tipoSelecionado == tipo;

    return GestureDetector(
      onTap: () => _controller.changeCategory(tipo, () => setState(() {})),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isActive ? activeColor : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: isActive
                  ? activeColor.withOpacity(0.3)
                  : Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: isActive ? Colors.white : Colors.grey, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : const Color(0xFF2D3142),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Alterna o corpo interno baseado no estado do Controller
  Widget _buildCategoryBody() {
    switch (_controller.tipoSelecionado) {
      case ETipoAtividade.ALIMENTACAO:
        return _buildTextForm(
          label: 'Descrição da Refeição',
          hint: 'Ex: Comeu a papinha de legumes toda e aceitou suco.',
          controller: _controller.foodController,
          themeColor: Colors.orange,
        );
      case ETipoAtividade.SONECA:
        return _buildSleepForm();
      case ETipoAtividade.HIGIENE:
        return _buildTextForm(
          label: 'Registro de Higiene',
          hint: 'Ex: Troca de fralda realizada. Sem assaduras.',
          controller: _controller.hygieneController,
          themeColor: Colors.green,
        );
    }
  }

  // Estrutura padrão para campos de texto (Alimentação e Higiene)
  Widget _buildTextForm({
    required String label,
    required String hint,
    required TextEditingController controller,
    required Color themeColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3142),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controller,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: hint,
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: themeColor, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildSaveButton(themeColor),
      ],
    );
  }

  // Estrutura específica para intervalo de horários (Sono)
  Widget _buildSleepForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Registro de Sono',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3142),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildTimeCard(
              label: 'Início do Sono',
              time: _controller.startTime,
              onTap: () async {
                final selected = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selected != null)
                  setState(() => _controller.startTime = selected);
              },
            ),
            const SizedBox(width: 16),
            _buildTimeCard(
              label: 'Fim do Sono',
              time: _controller.endTime,
              onTap: () async {
                final selected = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (selected != null)
                  setState(() => _controller.endTime = selected);
              },
            ),
          ],
        ),
        const SizedBox(height: 32),
        _buildSaveButton(Colors.purple),
      ],
    );
  }

  Widget _buildTimeCard({
    required String label,
    required TimeOfDay? time,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                time != null ? time.format(context) : '--:--',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3142),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSaveButton(Color color) {
    return ElevatedButton(
      onPressed: () async {
        final success = await _controller.saveRegistration(
          widget.studentId,
          widget.professorCpf,
        );
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registro salvo com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Por favor, preencha todos os campos.'),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Salvar Registro',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
