class DailyDataModel {
  int? bp_sys;
  int? bp_dias;
  double? temp;
  int? sugar;
  int? o2sat;
  String? activity;
  String? sleepcycle;
  String? foodintake;
  String? waterintake;
  String? motion;
  String? urine;

  DailyDataModel(
      {required this.bp_sys,
      required this.bp_dias,
      required this.temp,
      required this.sugar,
      required this.o2sat,
      required this.activity,
      required this.sleepcycle,
      required this.foodintake,
      required this.waterintake,
      required this.motion,
      required this.urine});

  DailyDataModel.fromJson(Map<String, Object> json)
      : this(
            bp_sys: json['bp_sys'] as int,
            bp_dias: json['bp_dias'] as int,
            temp: json['temp'] as double,
            sugar: json['sugar'] as int,
            o2sat: json['o2sat'] as int,
            activity: json['activity'] as String,
            sleepcycle: json['sleepcycle'] as String,
            foodintake: json['foodintake'] as String,
            waterintake: json['waterintake'] as String,
            motion: json['motion'] as String,
            urine: json['urine'] as String);

  DailyDataModel copyWith({
    int? bp_sys,
    int? bp_dias,
    double? temp,
    int? sugar,
    int? o2sat,
    String? activity,
    String? sleepcycle,
    String? foodintake,
    String? waterintake,
    String? motion,
    String? urine,
  }) {
    return DailyDataModel(
        bp_sys: bp_sys ?? this.bp_sys,
        bp_dias: bp_dias ?? this.bp_dias,
        temp: temp ?? this.temp,
        sugar: sugar ?? this.sugar,
        o2sat: o2sat ?? this.o2sat,
        activity: activity ?? this.activity,
        sleepcycle: sleepcycle ?? this.sleepcycle,
        foodintake: foodintake ?? this.foodintake,
        waterintake: waterintake ?? this.waterintake,
        motion: motion ?? this.motion,
        urine: urine ?? this.urine);
  }

  Map<String, dynamic> toJSon() {
    return {
      'bp_sys': bp_sys,
      'bp_dias': bp_dias,
      'temp': temp,
      'sugar': sugar,
      'o2sat': o2sat,
      'activity': activity,
      'sleepcycle': sleepcycle,
      'foodintake': foodintake,
      'waterintake': waterintake,
      'motion': motion,
      'urine': urine
    };
  }
}
