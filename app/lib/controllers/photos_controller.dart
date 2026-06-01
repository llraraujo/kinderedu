import '../models/photo_model.dart';
import 'package:kinderedu/models/header_model.dart';

class PhotosController {
  ChildProfile getChildProfile() {
    return childProfileHeader;
  }

  // Simula a busca das fotos postadas no dia
  List<PhotoEntry> getTodayPhotos() {
    return [
      PhotoEntry(
        imageUrl: 'https://images.unsplash.com/photo-1516627145497-ae6968895b74?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80', // Exemplo de crianças brincando
        description: 'Brincando com os blocos de montar',
        time: '14:30',
      ),
      PhotoEntry(
        imageUrl: 'https://images.unsplash.com/photo-1603354350317-6f7aaa5911c5?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80', // Exemplo de música
        description: 'Atividade de música e artes',
        time: '11:00',
      ),
      PhotoEntry(
        imageUrl: 'https://images.unsplash.com/photo-1519689680058-324335c77eba?ixlib=rb-4.0.3&auto=format&fit=crop&w=500&q=80', // Exemplo de bebê
        description: 'Hora do lanche da manhã',
        time: '09:30',
      ),
    ];
  }
}