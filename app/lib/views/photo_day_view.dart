import 'package:flutter/material.dart';
import 'package:kinderedu/components/header_component.dart';
import 'package:kinderedu/controllers/photos_controller.dart';
import 'package:kinderedu/models/header_model.dart';
import 'package:kinderedu/models/photo_model.dart';
import 'package:kinderedu/views/photo_gallery_view.dart';

class PhotoDayView extends StatefulWidget {
  final String month;
  final int year;
  final ChildProfile profile;
  final String cpfResponsavel;

  const PhotoDayView({
    Key? key,
    required this.month,
    required this.year,
    required this.profile,
    required this.cpfResponsavel,
  }) : super(key: key);

  @override
  State<PhotoDayView> createState() => _DiaryDayViewState();
}

class _DiaryDayViewState extends State<PhotoDayView> {
  final PhotosController _controller = PhotosController();
  late List<PhotoDayEntry> _days;

  @override
  void initState() {
    super.initState();
    _days = _controller.getDaysForMonth(widget.month, widget.year);
  }

  int getMonth(String month) {
    return _controller.monthNumberFromName(month);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      body: Column(
        children: [
          header(widget.profile),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildNavigationHeader(context),
                  const SizedBox(height: 20),
                  _buildDaysGrid(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Card com seta de voltar e título do mês
  Widget _buildNavigationHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.grey),
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.image_outlined, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Galeria de Fotos',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3142),
                ),
              ),
              Text(
                '${widget.month} de ${widget.year}',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Grade de Dias
  Widget _buildDaysGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 colunas como na imagem
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85, // Ajuste para o card ser levemente vertical
      ),
      itemCount: _days.length,
      itemBuilder: (context, index) {
        final dayEntry = _days[index];
        return InkWell(
          onTap: () {
            // Aqui navegaria para a Timeline (DiaryView) do dia específico
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhotoGalleryView(
                  date: DateTime(
                    widget.year,
                    getMonth(widget.month),
                    dayEntry.day,
                  ),
                  profile: widget.profile,
                  cpfResponsavel: widget.cpfResponsavel,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 5),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.image,
                  color: Color(0xFF4ADE80),
                  size: 28,
                ), // Ícone verde
                const SizedBox(height: 8),
                Text(
                  'Dia ${dayEntry.day}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const Text(
                  'Ver fotos',
                  style: TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
