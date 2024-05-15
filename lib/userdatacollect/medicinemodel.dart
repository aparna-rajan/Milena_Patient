// ignore_for_file: non_constant_identifier_names

class MedicineModel {
  String? medName;
  String? dosage;
  String? timing;
  String? ba_food;

  MedicineModel(
      {required this.medName,
      required this.dosage,
      required this.timing,
      required this.ba_food});

  MedicineModel.fromJson(Map<String, Object?> json)
      : this(
            medName: json['medName'] as String,
            dosage: json['dosage'] as String,
            timing: json['timing'] as String,
            ba_food: json['ba_food'] as String);

  MedicineModel copyWith({
    String? medName,
    String? dosage,
    String? timing,
    String? ba_food,
  }) {
    return MedicineModel(
        medName: medName ?? this.medName,
        dosage: dosage ?? this.dosage,
        timing: timing ?? this.timing,
        ba_food: ba_food ?? this.ba_food);
  }

  Map<String, dynamic> toJSon() {
    return {
      'medName': medName,
      'dosage': dosage,
      'timing': timing,
      'ba_food': ba_food
    };
  }
}
