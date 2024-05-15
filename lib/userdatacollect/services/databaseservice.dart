import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:milena_patient/alertsmanagement/alert_model.dart';
import 'package:milena_patient/userdatacollect/dailydatamodel.dart';
import 'package:milena_patient/userdatacollect/emergencymodel.dart';
import 'package:milena_patient/userdatacollect/healthmodel.dart';
import 'package:milena_patient/userdatacollect/medicinemodel.dart';
import 'package:milena_patient/userdatacollect/signupmodel.dart';

const String Usermodel_Collection_ref = 'Signupdata';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final CollectionReference _userRef;
  late DocumentReference documentRef;
  late CollectionReference dailydata;
  String? documentId;
  DatabaseService() {
    _userRef = _firestore.collection(Usermodel_Collection_ref);
  }

  Stream<QuerySnapshot> getSignupdata() {
    return _userRef.snapshots();
  }

  Future<String?> addsignupdata(UserModel signupmodel) async {
    // Add the UserModel to the Signupdata collection
    documentRef = await _userRef.add(signupmodel.toJson());
    try {
      documentId = documentRef.id;
      return documentId;
    } catch (e) {
      print('Exception:$e');
    }
    return null;
    // Create a new collection under the newly added document

    // Add data to the new collection (optional)
  }

  Future<void> addhealthdata(
      HealthModel healthModel, String? documentId) async {
    if (documentId == null || documentId.isEmpty) {
      throw ArgumentError('Invalid documentId: $documentId');
    }
    final CollectionReference healthInformationRef =
        _userRef.doc(documentId).collection('HealthInformation');
    await healthInformationRef.add(healthModel.toJSon());
  }

  Future<void> addmeddata(
      MedicineModel medicineModel, String? documentId) async {
    if (documentId == null || documentId.isEmpty) {
      throw ArgumentError('Invalid documentId: $documentId');
    }
    final CollectionReference medicineInformationRef =
        _userRef.doc(documentId).collection('MedicineInformation');
    await medicineInformationRef.add(medicineModel.toJSon());
  }

  Future<void> addemerdata(
      EmergencyModel emergencyModel, String? documentId) async {
    if (documentId == null || documentId.isEmpty) {
      throw ArgumentError('Invalid documentId: $documentId');
    }
    final CollectionReference emergencyInformationRef =
        _userRef.doc(documentId).collection('EmergencyInformation');
    await emergencyInformationRef.add(emergencyModel.toJSon());
  }

  Future<void> adddailydata(
      DailyDataModel dailyDataModel, String? documentId) async {
    if (documentId == null || documentId.isEmpty) {
      throw ArgumentError('Invalid documentId: $documentId');
    }
    final CollectionReference dailydataRef =
        _userRef.doc(documentId).collection('DailyData');
    await dailydataRef.add(dailyDataModel.toJSon());
  }

  Future<void> addalertdata(AlertModel alertModel, String? documentId) async {
    if (documentId == null || documentId.isEmpty) {
      throw ArgumentError('Invalid documentId: $documentId');
    }
    final CollectionReference alertref =
        _userRef.doc(documentId).collection('Alerts');
    await alertref.add(alertModel.toJson());
  }

  Future<String?> getHealthInfoDocId(String? signUpDataDocId) async {
    try {
      // Reference to the HealthInformation subcollection
      CollectionReference healthInfoRef = FirebaseFirestore.instance
          .collection('Signupdata')
          .doc(signUpDataDocId)
          .collection('HealthInformation');

      // Query the subcollection to get the documents
      QuerySnapshot querySnapshot = await healthInfoRef.get();

      // Check if there are any documents in the subcollection
      if (querySnapshot.docs.isNotEmpty) {
        // Assume you want to retrieve the first document's ID
        return querySnapshot.docs.first.id;
      } else {
        // No documents found in the subcollection
        return null;
      }
    } catch (e) {
      print('Error getting health information document ID: $e');
      return null; // Return null in case of error
    }
  }

  Future<String?> getExistingHealthConditions(
      String? signUpDataDocId, String? healthInfoDocId) async {
    try {
      // Reference to the document in the HealthInformation subcollection
      DocumentReference docRef = FirebaseFirestore.instance
          .collection('Signupdata')
          .doc(signUpDataDocId)
          .collection('HealthInformation')
          .doc(healthInfoDocId);

      // Get the document snapshot
      DocumentSnapshot snapshot = await docRef.get();

      // Check if the document exists
      if (snapshot.exists) {
        // Extract the value of the ExistingHealthConditions field
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          dynamic existingHealthConditions = data['ExistingHealthConditions'];

          // Check if the field is not null before returning its value
          if (existingHealthConditions != null) {
            return existingHealthConditions.toString();
          } else {
            return null; // Field value is null
          }
        }
      }

      return null; // Document does not exist or data is null
    } catch (e) {
      print('Error getting existing health conditions: $e');
      return null; // Return null in case of error
    }
  }

  Future<void> addsignificantsymptom(
      String? symptom, String? documentId) async {
    if (documentId == null || documentId.isEmpty) {
      throw ArgumentError('Invalid documentId: $documentId');
    }
    final CollectionReference alertref =
        _userRef.doc(documentId).collection('SignificantSymptoms');
    await alertref.add({'symptom': symptom});
  }
}
