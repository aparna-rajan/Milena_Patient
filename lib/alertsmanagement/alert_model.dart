class AlertModel {
  String? alert_nature;
  String? alert_message;
  DateTime? timestamp;

  AlertModel(
      {required this.alert_nature,
      required this.alert_message,
      required this.timestamp});

  AlertModel.fromJson(Map<String, Object> json)
      : this(
            alert_nature: json['alert_nature'] as String,
            alert_message: json['alert_message'] as String,
            timestamp: json['timestamp'] as DateTime);

  AlertModel copyWith(
      {String? alert_nature, String? alert_message, DateTime? timestamp}) {
    return AlertModel(
        alert_nature: alert_nature ?? this.alert_nature,
        alert_message: alert_message ?? this.alert_message,
        timestamp: timestamp ?? this.timestamp);
  }

  Map<String, dynamic> toJson() {
    return {
      'alert_nature': alert_nature,
      'alert_message': alert_message,
      'timestamp': timestamp
    };
  }
}
