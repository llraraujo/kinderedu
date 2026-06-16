class StudentOverview {
  final int id;
  final String name;
  final String age;
  final String responsibleName;
  final String imageUrl;

  StudentOverview({
    required this.id,
    required this.name,
    required this.age,
    required this.responsibleName,
    required this.imageUrl,
  });

  factory StudentOverview.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final imageUrl = json['imageUrl']?.toString() ?? '';
    return StudentOverview(
      id: id is int ? id : int.parse(id.toString()),
      name: json['name'] ?? '',
      age: json['age'] ?? 'N/A',
      responsibleName: json['responsibleName'] ?? '',
      imageUrl: imageUrl.isEmpty ? _defaultImageUrl(id) : imageUrl,
    );
  }

  static String _defaultImageUrl(Object? id) {
    final images = [
      'images/perfil.jpg',
      'images/perfil2.png',
      'images/perfil3.png',
      'images/perfil4.png',
    ];
    final numericId = int.tryParse(id.toString()) ?? 1;
    return images[(numericId - 1) % images.length];
  }
}

class ProfessorProfile {
  final String name;
  final String className;
  final String logoUrl;

  ProfessorProfile({
    required this.name,
    required this.className,
    required this.logoUrl,
  });
}
