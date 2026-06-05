enum RegisterCategory { food, sleep, hygiene }

class RegistrationModel {
  final String studentId;
  final RegisterCategory category;
  final String? textContent;
  final String? startTime;
  final String? endTime;
  final DateTime timestamp;

  RegistrationModel({
    required this.studentId,
    required this.category,
    this.textContent,
    this.startTime,
    this.endTime,
    required this.timestamp,
  });
}