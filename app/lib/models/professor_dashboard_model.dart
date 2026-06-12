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