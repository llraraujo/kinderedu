import 'package:flutter/material.dart';
import 'package:kinderedu/components/header_component.dart';
import 'package:kinderedu/models/header_model.dart';
import '../controllers/photos_controller.dart';
import '../models/photo_model.dart';

class PhotosView extends StatefulWidget {
  const PhotosView({Key? key}) : super(key: key);

  @override
  State<PhotosView> createState() => _PhotosViewState();
}

class _PhotosViewState extends State<PhotosView> {
  final PhotosController _controller = PhotosController();
  late List<PhotoEntry> _photos;
  late ChildProfile _profile;

  @override
  void initState() {
    super.initState();
    _photos = _controller.getTodayPhotos();
    _profile = _controller.getChildProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(_profile),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Galeria de Fotos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Momentos especiais da Ana Clara',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    '27/11/2025',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildPhotosGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  // Grade de fotos
  Widget _buildPhotosGrid() {
    return GridView.builder(
      shrinkWrap: true, // Necessário por estar dentro de um SingleChildScrollView
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Duas colunas
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.78, // Ajuste para dar espaço ao texto abaixo da imagem
      ),
      itemCount: _photos.length,
      itemBuilder: (context, index) {
        final photo = _photos[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem ocupando a parte superior do Card
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    photo.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover, // Garante que a imagem preencha a área sem distorcer
                  ),
                ),
              ),
              // Área de texto (Título e Horário)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      photo.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3142),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      photo.time,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}