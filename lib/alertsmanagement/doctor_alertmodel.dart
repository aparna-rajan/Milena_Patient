class DocAlertModel {
  String? alert_nature;
  String? alert_message;
  DateTime? timestamp;
  String? docId;

  DocAlertModel(
      {required this.alert_nature,
      required this.alert_message,
      required this.timestamp,
      required this.docId});

  DocAlertModel.fromJson(Map<String, Object> json)
      : this(
            alert_nature: json['alert_nature'] as String,
            alert_message: json['alert_message'] as String,
            timestamp: json['timestamp'] as DateTime,
            docId: json['patientdocId'] as String);

  DocAlertModel copyWith(
      {String? alert_nature,
      String? alert_message,
      DateTime? timestamp,
      String? docId}) {
    return DocAlertModel(
        alert_nature: alert_nature ?? this.alert_nature,
        alert_message: alert_message ?? this.alert_message,
        timestamp: timestamp ?? this.timestamp,
        docId: docId ?? this.docId);
  }

  Map<String, dynamic> toJson() {
    return {
      'alert_nature': alert_nature,
      'alert_message': alert_message,
      'timestamp': timestamp,
      'patientdocId': docId
    };
  }
}
