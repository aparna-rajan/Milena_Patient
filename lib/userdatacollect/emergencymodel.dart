class EmergencyModel {
  int? emergencyContact1;
  int? emergencyContact2;
  String? preferredHospital;
  String? doctor;

  EmergencyModel(
      {required this.emergencyContact1,
      required this.emergencyContact2,
      required this.preferredHospital,
      required this.doctor});

  EmergencyModel.fromJson(Map<String, Object> json)
      : this(
            emergencyContact1: json['emergencyContact1'] as int,
            emergencyContact2: json['emergencyContact2'] as int,
            preferredHospital: json['preferredHospital'] as String,
            doctor: json['doctor'] as String);

  EmergencyModel copyWith(
      {int? emergencyContact1,
      int? emergencyContact2,
      String? preferredHospital,
      String? doctor}) {
    return EmergencyModel(
        emergencyContact1: emergencyContact1 ?? this.emergencyContact1,
        emergencyContact2: emergencyContact2 ?? this.emergencyContact2,
        preferredHospital: preferredHospital ?? this.preferredHospital,
        doctor: doctor ?? this.doctor);
  }

  Map<String, dynamic> toJSon() {
    return {
      'emergencyContact1': emergencyContact1,
      'emergencyContact2': emergencyContact2,
      'preferredHospital': preferredHospital,
      'doctor': doctor
    };
  }
}
