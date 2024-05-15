// ignore_for_file: non_constant_identifier_names

class HealthModel {
  int? Height;
  int? Weight;
  String? ex_health_conditions;
  String? prev_surgery;
  String? curr_doctor;

  HealthModel(
      {required this.Height,
      required this.Weight,
      required this.ex_health_conditions,
      required this.prev_surgery,
      required this.curr_doctor});

  HealthModel.fromJson(Map<String, Object?> json)
      : this(
            Height: json['Height'] as int,
            Weight: json['Weight'] as int,
            ex_health_conditions: json['ExistingHealthConditions'] as String,
            prev_surgery: json['PreviousSurgeries'] as String,
            curr_doctor: json['CurrentDoctor'] as String);

  HealthModel copyWith({
    int? Height,
    int? Weight,
    String? ex_health_conditions,
    String? prev_surgery,
    String? curr_doctor,
  }) {
    return HealthModel(
        Height: Height ?? this.Height,
        Weight: Weight ?? this.Weight,
        ex_health_conditions: ex_health_conditions ?? this.ex_health_conditions,
        prev_surgery: prev_surgery ?? this.prev_surgery,
        curr_doctor: curr_doctor ?? this.curr_doctor);
  }

  Map<String, dynamic> toJSon() {
    return {
      'Height': Height,
      'Weight': Weight,
      'ExistingHealthConditions': ex_health_conditions,
      'PreviousSurgeries': prev_surgery,
      'CurrentDoctor': curr_doctor
    };
  }
}
