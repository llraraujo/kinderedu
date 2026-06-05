class ResponsibleModel {
  final String name;
  final String phone;

  ResponsibleModel({required this.name, required this.phone});
}

class EmergencyContactModel {
  final String name;
  final String relation;
  final String phone;

  EmergencyContactModel({required this.name, required this.relation, required this.phone});
}

class HealthRecordModel {
  final String allergies;
  final String medications;

  HealthRecordModel({required this.allergies, required this.medications});
}

class StudentFileModel {
  final ResponsibleModel responsible;
  final List<EmergencyContactModel> emergencyContacts;
  final HealthRecordModel healthInfo;

  StudentFileModel({
    required this.responsible,
    required this.emergencyContacts,
    required this.healthInfo,
  });
}