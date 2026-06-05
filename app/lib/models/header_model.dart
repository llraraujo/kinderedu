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
      name: 'Ana Clara',
      age: '8 meses',
      imageUrl: 'https://via.placeholder.com/150', // Substitua pela URL da foto
      currentDate: '27 de Novembro, 2025 • Quarta-feira',
);
