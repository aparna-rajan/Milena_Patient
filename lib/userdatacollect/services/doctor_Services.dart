import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:milena_patient/alertsmanagement/doctor_alertmodel.dart';

const String Doctor_Collection_ref = 'Dr.signup';

class DoctorServices {
  late final CollectionReference doctorref;
  late DocumentReference documentRef;
  late CollectionReference dailydata;
  String? documentId;
  DoctorServices({required this.documentId});

  Future<void> addalert_doc(
      DocAlertModel docAlertModel, String? documentId) async {
    if (documentId == null || documentId.isEmpty) {
      throw ArgumentError('Invalid documentId: $documentId');
    }

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Dr.signup').doc(documentId);

    CollectionReference doctoralertref = documentReference.collection('Alerts');
    await doctoralertref.add(docAlertModel.toJson());
  }

  Future<void> addalert_doc_notindb(DocAlertModel docAlertModel,
      String? alert_data, String? documentId) async {
    if (documentId == null || documentId.isEmpty) {
      throw ArgumentError('Invalid documentId: $documentId');
    }

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Dr.signup').doc(documentId);

    CollectionReference doctoralertref = documentReference.collection('Alerts');
    await doctoralertref.add(docAlertModel);
    await doctoralertref.add({'alert_data': alert_data});
  }

  Future<void> addalert_doc_significantSymptom(
      DocAlertModel docAlertModel, String? documentId) async {
    if (documentId == null || documentId.isEmpty) {
      throw ArgumentError('Invalid documentId: $documentId');
    }

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('Dr.signup').doc(documentId);

    CollectionReference doctoralertref = documentReference.collection('Alerts');
    await doctoralertref.add(docAlertModel.toJson());
  }
}
