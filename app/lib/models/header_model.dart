class ChildProfile {
  final String name;
  final String age;
  final String imageUrl;
  final String currentDate;

  ChildProfile({
    required this.name,
    required this.age,
    required this.imageUrl,
    required this.currentDate,
  });
}

var childProfileHeader = ChildProfile(
      name: 'Maria Laura',
      age: '2 anos',
      imageUrl: 'images/perfil.jpg', // Substitua pela URL da foto
      currentDate: '27 de Maio, 2026 • Quarta-feira',
);