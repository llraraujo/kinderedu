import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kinderedu/services/api_config.dart';

import '../models/add_photo_model.dart';

class AddPhotoController {
  final String baseURL = ApiConfig.baseUrl;
  final ImagePicker _picker = ImagePicker();

  Future<bool> takePhotoFromCamera(
    StudentPhotoContext student, {
    String? descricao,
  }) async {
    final photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo == null) {
      return false;
    }

    await _uploadPhoto(photo, student, descricao: descricao);
    return true;
  }

  Future<bool> pickPhotoFromGallery(
    StudentPhotoContext student, {
    String? descricao,
  }) async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return false;
    }

    await _uploadPhoto(image, student, descricao: descricao);
    return true;
  }

  Future<void> _uploadPhoto(
    XFile image,
    StudentPhotoContext student, {
    String? descricao,
  }) async {
    final uri = Uri.parse(
      '$baseURL/alunos/${student.studentId}/fotos',
    ).replace(queryParameters: {'cpfProfessor': student.professorCpf});

    final request = http.MultipartRequest('POST', uri)
      ..fields['dataHora'] = DateTime.now().toIso8601String();

    if (descricao != null && descricao.trim().isNotEmpty) {
      request.fields['descricao'] = descricao.trim();
    }

    request.files.add(
      http.MultipartFile.fromBytes(
        'foto',
        await image.readAsBytes(),
        filename: image.name,
      ),
    );

    final response = await request.send();
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Erro ao enviar foto: ${response.statusCode}');
    }
  }
}
