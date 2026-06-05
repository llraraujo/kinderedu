import 'package:flutter/material.dart';
import 'package:kinderedu/components/header_component.dart';
import 'package:kinderedu/models/header_model.dart';
import '../controllers/photos_controller.dart';
import '../models/photo_model.dart';

class PhotoGalleryView extends StatefulWidget {
  const PhotoGalleryView({Key? key, required this.date}) : super(key: key);
  final DateTime date;
  @override
  State<PhotoGalleryView> createState() => _PhotoGalleryViewState();
}

class _PhotoGalleryViewState extends State<PhotoGalleryView> {
  final PhotosController _controller = PhotosController();
  late List<PhotoGallery> _photos;
  late ChildProfile _profile;

  @override
  void initState() {
    super.initState();
    _profile = _controller.getChildProfile();
    _photos = _controller.getPhotosGallery(widget.date);
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
                  _buildNavigationHeader(context),
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

  
  String getMonth(int month){
    switch(month){
      case 10: return "Outubro";
      case 11: return "Novembro";
      case 12: return "Dezembro";
      default: return "";
    }    
  }

  
  Widget _buildNavigationHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.grey),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.image_outlined, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Galeria de fotos', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF2D3142))),
              Text('${widget.date.day} de ${getMonth(widget.date.month)} de ${widget.date.year}', style: TextStyle(fontSize: 13, color: Colors.grey)),
            ],
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