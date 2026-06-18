import 'package:flutter/material.dart';

import '../controllers/add_photo_controller.dart';
import '../models/add_photo_model.dart';

class AddPhotoView extends StatefulWidget {
  final StudentPhotoContext studentContext;

  const AddPhotoView({Key? key, required this.studentContext})
    : super(key: key);

  @override
  State<AddPhotoView> createState() => _AddPhotoViewState();
}

class _AddPhotoViewState extends State<AddPhotoView> {
  final AddPhotoController _controller = AddPhotoController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isUploading = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

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
          CircleAvatar(radius: 18, backgroundImage: _studentImageProvider()),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Adicionar Foto',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3142),
                ),
              ),
              Text(
                widget.studentContext.studentName,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUploadCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFFF3E8FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: Color(0xFFA855F7),
              size: 32,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Adicionar Foto',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3142),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Compartilhe momentos especiais com os pais',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 28),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Descricao',
              hintText: 'Ex: Brincando no patio',
              prefixIcon: Icon(Icons.notes_outlined),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 24),
          _buildActionButton(
            label: 'Tirar Foto',
            icon: Icons.camera_alt_outlined,
            backgroundColor: const Color(0xFFA855F7),
            onTap: _uploadFromCamera,
          ),
          const SizedBox(height: 16),
          _buildActionButton(
            label: 'Galeria',
            icon: Icons.file_upload_outlined,
            backgroundColor: const Color(0xFF6366F1),
            onTap: _uploadFromGallery,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: _isUploading ? null : onTap,
        icon: _isUploading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Icon(icon, color: Colors.white, size: 20),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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

  Widget _buildTipBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F5FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, size: 18, color: Color(0xFF7E22CE)),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Os pais poderao visualizar a foto na galeria do dia em que ela foi enviada.',
              style: TextStyle(
                color: Color(0xFF7E22CE),
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

  Future<void> _uploadFromCamera() async {
    await _executeUpload(
      () => _controller.takePhotoFromCamera(
        widget.studentContext,
        descricao: _descriptionController.text,
      ),
    );
  }

  Future<void> _uploadFromGallery() async {
    await _executeUpload(
      () => _controller.pickPhotoFromGallery(
        widget.studentContext,
        descricao: _descriptionController.text,
      ),
    );
  }

  Future<void> _executeUpload(Future<bool> Function() uploadAction) async {
    setState(() {
      _isUploading = true;
    });

    try {
      final uploaded = await uploadAction();
      if (!mounted) {
        return;
      }

      if (uploaded) {
        _descriptionController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Foto enviada com sucesso.')),
        );
      }
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nao foi possivel enviar a foto: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  ImageProvider _studentImageProvider() {
    final imageUrl = widget.studentContext.imageUrl;
    if (imageUrl.startsWith('http')) {
      return NetworkImage(imageUrl);
    }

    return AssetImage(imageUrl);
  }
}
