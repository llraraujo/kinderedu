class StudentOverview {
  final String id;
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
  final int studentCount;
  final String logoUrl;

  ProfessorProfile({
    required this.name,
    required this.className,
    required this.studentCount,
    required this.logoUrl,
  });
}