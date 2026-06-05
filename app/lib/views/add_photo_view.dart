import 'package:flutter/material.dart';
import '../controllers/add_photo_controller.dart';
import '../models/add_photo_model.dart';

class AddPhotoView extends StatefulWidget {
  final StudentPhotoContext studentContext;

  const AddPhotoView({
    Key? key,
    required this.studentContext,
  }) : super(key: key);

  @override
  State<AddPhotoView> createState() => _AddPhotoViewState();
}

class _AddPhotoViewState extends State<AddPhotoView> {
  final AddPhotoController _controller = AddPhotoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: _buildCustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              _buildUploadCard(),
              const SizedBox(height: 24),
              _buildTipBox(),
            ],
          ),
        ),
      ),
    );
  }

  // AppBar customizada com foto e nome do aluno
  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF2D3142)),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(widget.studentContext.imageUrl),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Adicionar Foto',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
              ),
              Text(
                widget.studentContext.studentName,
                style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Card principal de ação
  Widget _buildUploadCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        // Nota: Para borda tracejada real, utilize o package dotted_border
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        children: [
          // Ícone circular no topo
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF3E8FF), // Fundo roxo muito claro
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.camera_alt_outlined, color: Color(0xFFA855F7), size: 32),
          ),
          const SizedBox(height: 20),
          const Text(
            'Adicionar Foto',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
          ),
          const SizedBox(height: 8),
          Text(
            'Compartilhe momentos especiais com os pais',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 32),
          
          // Botão Tirar Foto
          _buildActionButton(
            label: 'Tirar Foto',
            icon: Icons.camera_alt_outlined,
            backgroundColor: const Color(0xFFA855F7), // Roxo vibrante
            onTap: () => _controller.takePhotoFromCamera(widget.studentContext),
          ),
          const SizedBox(height: 16),
          
          // Botão Galeria
          _buildActionButton(
            label: 'Galeria',
            icon: Icons.file_upload_outlined,
            backgroundColor: const Color(0xFF6366F1), // Azul/Indigo
            onTap: () => _controller.pickPhotoFromGallery(widget.studentContext),
          ),
        ],
      ),
    );
  }

  // Método auxiliar para criar os botões padronizados
  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: Colors.white, size: 20),
        label: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // Caixa de dica amigável (UX)
  Widget _buildTipBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F5FF), // Roxo hiper claro
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('💡', style: TextStyle(fontSize: 16)),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Dica: Os pais receberão uma notificação instantânea quando você enviar a foto.',
              style: TextStyle(
                color: Color(0xFF7E22CE), // Roxo escuro para contraste de leitura
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}