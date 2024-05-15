// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:milena_patient/alertsmanagement/alert_model.dart';
import 'package:milena_patient/alertsmanagement/doctor_alertmodel.dart';
import 'package:milena_patient/userdatacollect/dailydatamodel.dart';
import 'package:milena_patient/userdatacollect/services/databaseservice.dart';
import 'package:milena_patient/userdatacollect/services/doctor_Services.dart';

class Alerts {
  int? bp_sys;
  int? bp_dias;
  int? sugar;
  int? o2sat;
  double? temp;
  String? activity;
  String? sleepcycle;
  String? foodintake;
  String? waterintake;
  String? motion;
  String? urine;
  String? id;

  Alerts(DailyDataModel dataModel, String? id) {
    bp_sys = dataModel.bp_sys;
    bp_dias = dataModel.bp_dias;
    sugar = dataModel.sugar;
    o2sat = dataModel.o2sat;
    temp = dataModel.temp as double;
    activity = dataModel.activity; // user input--> [low], moderate, high
    sleepcycle = dataModel.sleepcycle; // user input--> [low], moderate,[high]
    foodintake = dataModel.foodintake; // user input--> [low], moderate, high
    waterintake =
        dataModel.waterintake; // user input--> [low], moderate, [high]
    motion = dataModel.motion; // user input--> [low], moderate,[high]
    urine = dataModel.urine;
    id = id; // user input--> [low], moderate, [high]
  }

//moderate level: count=3, ==> moderate level to patient[], alert to doctor
//high level: count>3,==> high level to patient[]
  Future<void> findAlert(String? healthcond, String? id) async {
    switch (healthcond) {
      case 'Hypertension' || 'High BP':
        findAlert_HyperTension(id);
        break;
      case 'Diabetes' || 'Sugar':
        findAlert_diabetes(id);
        break;
      case 'Alzheimers':
        findAlert_alzheimers(id);
        break;
      case 'Renal' || 'kidney':
        findAlert_kidneyFailure(id);
        break;
      case 'Cholestrol':
        findAlert_cholesterol(id);
        break;
      case 'Arthritis':
        findAlert_arithritis(id);
        break;
      case 'Heart Problems' || 'Cardiac Issues':
        findAlert_heartdisease(id);
        break;
      case 'Depression':
        findAlert_depression(id);
        break;
      case 'Pulmonary Disease' || 'Lung Diseases':
        findAlert_pulmonarydisease(id);
        break;
      case 'no' || 'nil' || null:
        findAlert_noHealthConditions(id);
        break;
      default:
        print(
            'Moderate Alert to Doctor'); //alert stored to doctor, no alert to patient
        String? alert_message =
            'Health condition doesnt exist in our database. Please advise the patient accordingly.';

        String? alert_nature = 'Not in DB';
        String? alert_data =
            'BP : $bp_sys/$bp_dias , Sugar level : $sugar , O2 sats : $o2sat , Temperature : $temp , Activity Level : $activity , Sleep-Cycle : $sleepcycle , Food Intake : $foodintake , Water Intake : $waterintake , Motion Output : $motion , Urine : $urine';
        DocAlertModel docAlertModel = DocAlertModel(
            alert_nature: alert_nature,
            alert_message: alert_message,
            timestamp: DateTime.now(),
            docId: id);
        DoctorServices doctorServices =
            DoctorServices(documentId: await fetchDocId(id));
        doctorServices.addalert_doc_notindb(
            docAlertModel, alert_data, await fetchDocId(id));
    }
  }

  Future<void> findAlert_noHealthConditions(String? id) async {
    String? alert_message = '';
    int count = 0;
    //BP
    if (bp_dias! < 65 && bp_sys! < 120 || bp_dias! < 65 && bp_sys! > 100) {
      print("Low Risk Alert: BP is LOW");
      alert_message += 'BP Low : $bp_sys/$bp_dias ,';
      count += 1;
    } else if (bp_dias! > 90 && bp_sys! > 140) {
      print("Low Risk Alert: BP is HIGH");
      alert_message += 'BP High : $bp_sys/$bp_dias ,';
      count += 1;
    }
    if (sugar! < 70) {
      print("Low sugar level");
      alert_message += 'Sugar Level Low : $sugar ,';
      count += 1;
    } else if (sugar! > 200) {
      print("High sugar level");
      alert_message += 'Sugar Level High : $sugar ,';
      count += 1;
    }
    if (o2sat! < 95) {
      print("Low oxygen level");
      alert_message += 'O2 sats Low : $o2sat ,';
      count += 1;
    } else if (o2sat! > 100) {
      print("High o2 level");
      alert_message += 'O2 sats High : $o2sat ,';
      count += 1;
    }
    if (temp! < 89.6) {
      print("low Temperature");
      alert_message += 'Temperature Low : $temp ,';
      count += 1;
    } else if (temp! > 100.4) {
      print("High temperature");
      alert_message += 'Temperature High : $temp ,';
      count += 1;
    }

    //sugar
    if (activity! == 'low') {
      alert_message += 'Low Activity level ,';
      count = count + 1;
    }
    if (sleepcycle! == 'low' || sleepcycle! == 'high') {
      alert_message += 'Sleep cycle irregular : $sleepcycle,';
      count = count + 1;
    }
    if (foodintake! == 'low') {
      alert_message += 'Food intake Low,';
      count = count + 1;
    }
    if (waterintake! == 'low' || waterintake! == 'high') {
      alert_message += 'Abnormal Water Intake : $waterintake,';
      count = count + 1;
    }
    if (motion != 'low' || motion != 'high') {
      alert_message += 'Motion Ouput abnormal : $motion,';
      count = count + 1;
    }
    if (urine! == 'low' || urine == 'high') {
      alert_message += 'Urine output abnormal : $urine,';
      count = count + 1;
    }
    if (count <= 2) {
      print("There is no risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Low',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    } else if (count > 2 && count <= 5) {
      print("The condition is moderate level of risk :Alert to patient");
      print("The condition is moderate level of risk:Alert to doctor");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
      DocAlertModel docAlertModel = DocAlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now(),
          docId: id);
      DoctorServices doctorServices = DoctorServices(documentId: id);
      doctorServices.addalert_doc(docAlertModel, id);
    } else if (count > 5) {
      print("The condition is highly at risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'High',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    }
    //
  }

  Future<void> findAlert_HyperTension(String? id) async {
    int count = 0;
    String? alert_message = 'Existing Health Condition : Hypertension , ';
    //BP
    if (bp_dias! < 60 && bp_sys! < 90) {
      print("Low Risk Alert: BP is LOW");
      count = count + 1;
      alert_message += 'BP Low : $bp_sys/$bp_dias ,';
    } else if (bp_dias! > 90 && bp_sys! > 140) {
      print("Low Risk Alert: BP is HIGH");
      count = count + 1;
      alert_message += 'BP High : $bp_sys/$bp_dias ,';
    }
    if (sugar! < 70) {
      print("Low sugar level");
      count = count + 1;
      alert_message += 'Sugar Level Low : $sugar ,';
    } else if (sugar! > 200) {
      print("High sugar level");
      count = count + 1;
      alert_message += 'Sugar Level High : $sugar ,';
    }
    if (o2sat! < 95) {
      print("Low oxygen level");
      count = count + 1;
      alert_message += 'O2 sats Low : $o2sat ,';
    } else if (o2sat! > 100) {
      print("High o2 level");
      count = count + 1;
      alert_message += 'O2 sats High : $o2sat ,';
    }
    if (temp! < 95) {
      print("low Temperature");
      count = count + 1;
      alert_message += 'Temperature Low : $temp ,';
    } else if (temp! > 100.4) {
      print("High temperature");
      count = count + 1;
      alert_message += 'Temperature High : $temp ,';
    }
    //sugar
    if (activity! == 'low') {
      alert_message += 'Low Activity level ,';
      count = count + 1;
    }
    if (sleepcycle! == 'low' || sleepcycle! == 'high') {
      alert_message += 'Sleep cycle irregular : $sleepcycle,';
      count = count + 1;
    }
    if (foodintake! == 'low') {
      alert_message += 'Food intake Low,';
      count = count + 1;
    }
    if (waterintake! == 'low' || waterintake! == 'high') {
      alert_message += 'Abnormal Water Intake : $waterintake,';
      count = count + 1;
    }
    if (motion! == 'low' || motion! == 'high') {
      alert_message += 'Motion Ouput abnormal : $motion,';
      count = count + 1;
    }
    if (urine! == 'low' || urine == 'high') {
      count = count + 1;
      alert_message += 'Urine output abnormal : $urine,';
    }
    if (count <= 2) {
      print("There is no risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Low',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    } else if (count > 2 && count <= 5) {
      print("The condition is moderate level of risk :Alert to patient");
      print("The condition is moderate level of risk:Alert to doctor");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
      DocAlertModel docAlertModel = DocAlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now(),
          docId: id);
      DoctorServices doctorServices =
          DoctorServices(documentId: await fetchDocId(id));
      doctorServices.addalert_doc(docAlertModel, await fetchDocId(id));
    } else if (count > 5) {
      print("The condition is highly at risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'High',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    }
    //
    //
  }

  Future<void> findAlert_diabetes(String? id) async {
    int count = 0;
    String? alert_message = 'Existing Health Condition : Diabetes , ';
    //BP
    if (bp_dias! < 60 && bp_sys! < 90) {
      print("Low Risk Alert: BP is LOW");
      count = count + 1;
      alert_message += 'BP Low : $bp_sys/$bp_dias ,';
    } else if (bp_dias! > 80 && bp_sys! > 130) {
      print("Low Risk Alert: BP is HIGH");
      count = count + 1;
      alert_message += 'BP High : $bp_sys/$bp_dias ,';
    }
    if (sugar! < 70) {
      print("Low sugar level");
      count = count + 1;
      alert_message += 'Sugar Level Low : $sugar ,';
    } else if (sugar! > 130) {
      print("High sugar level");
      count = count + 1;
      alert_message += 'Sugar Level High : $sugar ,';
    }
    if (o2sat! < 95) {
      print("Low oxygen level");
      count = count + 1;
      alert_message += 'O2 sats Low : $o2sat ,';
    } else if (o2sat! > 100) {
      print("High o2 level");
      count = count + 1;
      alert_message += 'O2 sats High : $o2sat ,';
    }
    if (temp! < 96.8) {
      print("low Temperature");
      count = count + 1;
      alert_message += 'Temperature Low : $temp ,';
    } else if (temp! > 100.4) {
      print("High temperature");
      count = count + 1;
      alert_message += 'Temperature High : $temp ,';
    }

    //sugar
    if (activity! == 'low') {
      alert_message += 'Low Activity level ,';
      count = count + 1;
    }
    if (sleepcycle! == 'low' || sleepcycle! == 'high') {
      alert_message += 'Sleep cycle irregular : $sleepcycle,';
      count = count + 1;
    }
    if (foodintake! == 'low') {
      alert_message += 'Food intake Low,';
      count = count + 1;
    }
    if (waterintake! == 'low' || waterintake! == 'high') {
      alert_message += 'Abnormal Water Intake : $waterintake,';
      count = count + 1;
    }
    if (motion! == 'low' || motion! == 'high') {
      alert_message += 'Motion Ouput abnormal : $motion,';
      count = count + 1;
    }
    if (urine! == 'low' || urine == 'high') {
      count = count + 1;
      alert_message += 'Urine output abnormal : $urine,';
    }
    if (count <= 2) {
      print("There is no risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Low',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    } else if (count > 2 && count <= 5) {
      print("The condition is moderate level of risk :Alert to patient");
      print("The condition is moderate level of risk:Alert to doctor");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
      DocAlertModel docAlertModel = DocAlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now(),
          docId: id);
      DoctorServices doctorServices =
          DoctorServices(documentId: await fetchDocId(id));
      doctorServices.addalert_doc(docAlertModel, await fetchDocId(id));
    } else if (count > 5) {
      print("The condition is highly at risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'High',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    }
    //
    //
  }

  Future<void> findAlert_alzheimers(String? id) async {
    int count = 0;
    String? alert_message = 'Existing Health Condition : Alzheimers , ';
    //BP
    if (bp_dias! < 60 && bp_sys! < 90) {
      print("Low Risk Alert: BP is LOW");
      count = count + 1;
      alert_message += 'BP Low : $bp_sys/$bp_dias ,';
    } else if (bp_dias! > 80 && bp_sys! > 130) {
      print("Low Risk Alert: BP is HIGH");
      count = count + 1;
      alert_message += 'BP High : $bp_sys/$bp_dias ,';
    }
    if (sugar! < 70) {
      print("Low sugar level");
      count = count + 1;
      alert_message += 'Sugar Level Low : $sugar ,';
    } else if (sugar! > 130) {
      print("High sugar level");
      count = count + 1;
      alert_message += 'Sugar Level High : $sugar ,';
    }
    if (o2sat! < 95) {
      print("Low oxygen level");
      count = count + 1;
      alert_message += 'O2 sats Low : $o2sat ,';
    } else if (o2sat! > 100) {
      print("High o2 level");
      count = count + 1;
      alert_message += 'O2 sats High : $o2sat ,';
    }
    if (temp! < 96.8) {
      print("low Temperature");
      count = count + 1;
      alert_message += 'Temperature Low : $temp ,';
    } else if (temp! > 100.4) {
      print("High temperature");
      count = count + 1;
      alert_message += 'Temperature High: $temp ,';
    }

    //sugar
    if (activity! == 'low') {
      alert_message += 'Low Activity level ,';
      count = count + 1;
    }
    if (sleepcycle! == 'low' || sleepcycle! == 'high') {
      alert_message += 'Sleep cycle irregular : $sleepcycle,';
      count = count + 1;
    }
    if (foodintake! == 'low') {
      alert_message += 'Food intake Low,';
      count = count + 1;
    }
    if (waterintake! == 'low' || waterintake! == 'high') {
      alert_message += 'Abnormal Water Intake : $waterintake,';
      count = count + 1;
    }
    if (motion! == 'low' || motion! == 'high') {
      alert_message += 'Motion Ouput abnormal : $motion,';
      count = count + 1;
    }
    if (urine! == 'low' || urine == 'high') {
      count = count + 1;
      alert_message += 'Urine output abnormal : $urine,';
    }
    if (count <= 2) {
      print("There is no risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Low',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    } else if (count > 2 && count <= 5) {
      print("The condition is moderate level of risk :Alert to patient");
      print("The condition is moderate level of risk:Alert to doctor");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
      DocAlertModel docAlertModel = DocAlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now(),
          docId: id);
      DoctorServices doctorServices =
          DoctorServices(documentId: await fetchDocId(id));
      doctorServices.addalert_doc(docAlertModel, await fetchDocId(id));
    } else if (count > 5) {
      print("The condition is highly at risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'High',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    }
    //
    //
  }

  Future<void> findAlert_kidneyFailure(String? id) async {
    int count = 0;
    String? alert_message = 'Existing Health Condition : Kidney Failure , ';
    //BP
    if (bp_dias! < 60 && bp_sys! < 90) {
      print("Low Risk Alert: BP is LOW");
      count = count + 1;
      alert_message += 'BP Low : $bp_sys/$bp_dias ,';
    } else if (bp_dias! > 80 && bp_sys! > 130) {
      print("Low Risk Alert: BP is HIGH");
      count = count + 1;
      alert_message += 'BP High : $bp_sys/$bp_dias ,';
    }
    if (sugar! < 70) {
      print("Low sugar level");
      count = count + 1;
      alert_message += 'Sugar Level Low : $sugar ,';
    } else if (sugar! > 130) {
      print("High sugar level");
      count = count + 1;
      alert_message += 'Sugar Level High : $sugar ,';
    }
    if (o2sat! < 90) {
      print("Low oxygen level");
      count = count + 1;
      alert_message += 'O2 sats Low : $o2sat ,';
    } else if (o2sat! > 100) {
      print("High o2 level");
      count = count + 1;
      alert_message += 'O2 sats High : $o2sat ,';
    }
    if (temp! < 96.8) {
      print("low Temperature");
      count = count + 1;
      alert_message += 'Temperature Low : $temp ,';
    } else if (temp! > 100.4) {
      print("High temperature");
      count = count + 1;
      alert_message += 'Temperature High : $temp ,';
    }

    //sugar
    if (activity! == 'low') {
      alert_message += 'Low Activity level ,';
      count = count + 1;
    }
    if (sleepcycle! == 'low' || sleepcycle! == 'high') {
      alert_message += 'Sleep cycle irregular : $sleepcycle,';
      count = count + 1;
    }
    if (foodintake! == 'low') {
      alert_message += 'Food intake Low,';
      count = count + 1;
    }
    if (waterintake! == 'low' || waterintake! == 'high') {
      alert_message += 'Abnormal Water Intake : $waterintake,';
      count = count + 1;
    }
    if (motion! == 'low' || motion! == 'high') {
      alert_message += 'Motion Ouput abnormal : $motion,';
      count = count + 1;
    }
    if (urine! == 'low' || urine == 'high') {
      count = count + 1;
      alert_message += 'Urine output abnormal : $urine,';
    }
    if (count <= 2) {
      print("There is no risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Low',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    } else if (count > 2 && count <= 5) {
      print("The condition is moderate level of risk :Alert to patient");
      print("The condition is moderate level of risk:Alert to doctor");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
      DocAlertModel docAlertModel = DocAlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now(),
          docId: id);
      DoctorServices doctorServices =
          DoctorServices(documentId: await fetchDocId(id));
      doctorServices.addalert_doc(docAlertModel, await fetchDocId(id));
    } else if (count > 5) {
      print("The condition is highly at risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'High',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    }
    //
    //
  }

  Future<void> findAlert_cholesterol(String? id) async {
    int count = 0;
    String? alert_message = 'Existing Health Condition : Cholesterol , ';
    //BP
    if (bp_dias! < 60 && bp_sys! < 90) {
      print("Low Risk Alert: BP is LOW");
      count = count + 1;
      alert_message += 'BP Low : $bp_sys/$bp_dias ,';
    } else if (bp_dias! > 80 && bp_sys! > 120) {
      print("Low Risk Alert: BP is HIGH");
      count = count + 1;
      alert_message += 'BP High : $bp_sys/$bp_dias ,';
    }
    if (sugar! < 70) {
      print("Low sugar level");
      count = count + 1;
      alert_message += 'Sugar Level Low : $sugar ,';
    } else if (sugar! > 100) {
      print("High sugar level");
      count = count + 1;
      alert_message += 'Sugar Level High : $sugar ,';
    }
    if (o2sat! < 95) {
      print("Low oxygen level");
      count = count + 1;
      alert_message += 'O2 sats Low : $o2sat ,';
    } else if (o2sat! > 100) {
      print("High o2 level");
      count = count + 1;
      alert_message += 'O2 sats High : $o2sat ,';
    }
    if (temp! < 96.8) {
      print("low Temperature");
      count = count + 1;
      alert_message += 'Temperature Low : $temp ,';
    } else if (temp! > 98.6) {
      print("High temperature");
      count = count + 1;
      alert_message += 'Temperature High : $temp ,';
    }

    //sugar
    if (activity! == 'low') {
      alert_message += 'Low Activity level ,';
      count = count + 1;
    }
    if (sleepcycle! == 'low' || sleepcycle! == 'high') {
      alert_message += 'Sleep cycle irregular : $sleepcycle,';
      count = count + 1;
    }
    if (foodintake! == 'low') {
      alert_message += 'Food intake Low,';
      count = count + 1;
    }
    if (waterintake! == 'low' || waterintake! == 'high') {
      alert_message += 'Abnormal Water Intake : $waterintake,';
      count = count + 1;
    }
    if (motion! == 'low' || motion! == 'high') {
      alert_message += 'Motion Ouput abnormal : $motion,';
      count = count + 1;
    }
    if (urine! == 'low' || urine == 'high') {
      count = count + 1;
      alert_message += 'Urine output abnormal : $urine,';
    }
    if (count <= 2) {
      print("There is no risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Low',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    } else if (count > 2 && count <= 5) {
      print("The condition is moderate level of risk :Alert to patient");
      print("The condition is moderate level of risk:Alert to doctor");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
      DocAlertModel docAlertModel = DocAlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now(),
          docId: id);
      DoctorServices doctorServices =
          DoctorServices(documentId: await fetchDocId(id));
      doctorServices.addalert_doc(docAlertModel, await fetchDocId(id));
    } else if (count > 5) {
      print("The condition is highly at risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'High',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    }
    //

    //
  }

  Future<void> findAlert_arithritis(String? id) async {
    int count = 0;
    String? alert_message = 'Existing Health Condition : Arithritis , ';
    //BP
    if (bp_dias! < 60 && bp_sys! < 90) {
      print("Low Risk Alert: BP is LOW");
      count = count + 1;
      alert_message += 'BP Low : $bp_sys/$bp_dias ,';
    } else if (bp_dias! > 80 && bp_sys! > 120) {
      print("Low Risk Alert: BP is HIGH");
      count = count + 1;
      alert_message += 'BP High : $bp_sys/$bp_dias ,';
    }
    if (sugar! < 70) {
      print("Low sugar level");
      count = count + 1;
      alert_message += 'Sugar Level Low : $sugar ,';
    } else if (sugar! > 100) {
      print("High sugar level");
      count = count + 1;
      alert_message += 'Sugar Level High : $sugar ,';
    }
    if (o2sat! < 95) {
      print("Low oxygen level");
      count = count + 1;
      alert_message += 'O2 sats Low : $o2sat ,';
    } else if (o2sat! > 100) {
      print("High o2 level");
      count = count + 1;
      alert_message += 'O2 sats High: $o2sat ,';
    }
    if (temp! < 96.8) {
      print("low Temperature");
      count = count + 1;
      alert_message += 'Temperature Low : $temp ,';
    } else if (temp! > 98.6) {
      print("High temperature");
      count = count + 1;
      alert_message += 'Temperature High: $temp ,';
    }

    //sugar
    if (activity! == 'low') {
      alert_message += 'Low Activity level ,';
      count = count + 1;
    }
    if (sleepcycle! == 'low' || sleepcycle! == 'high') {
      alert_message += 'Sleep cycle irregular : $sleepcycle,';
      count = count + 1;
    }
    if (foodintake! == 'low') {
      alert_message += 'Food intake Low,';
      count = count + 1;
    }
    if (waterintake! == 'low' || waterintake! == 'high') {
      alert_message += 'Abnormal Water Intake : $waterintake,';
      count = count + 1;
    }
    if (motion! == 'low' || motion! == 'high') {
      alert_message += 'Motion Ouput abnormal : $motion,';
      count = count + 1;
    }
    if (urine! == 'low' || urine == 'high') {
      count = count + 1;
      alert_message += 'Urine output abnormal : $urine,';
    }
    if (count <= 2) {
      print("There is no risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Low',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    } else if (count > 2 && count <= 5) {
      print("The condition is moderate level of risk :Alert to patient");
      print("The condition is moderate level of risk:Alert to doctor");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
      DocAlertModel docAlertModel = DocAlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now(),
          docId: id);
      DoctorServices doctorServices =
          DoctorServices(documentId: await fetchDocId(id));
      doctorServices.addalert_doc(docAlertModel, await fetchDocId(id));
    } else if (count > 5) {
      print("The condition is highly at risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'High',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    }
  }

  Future<void> findAlert_heartdisease(String? id) async {
    int count = 0;
    String? alert_message = 'Existing Health Condition : Heart Disease , ';
    //BP
    if (bp_dias! < 60 && bp_sys! < 90) {
      print("Low Risk Alert: BP is LOW");
      count = count + 1;
      alert_message += 'BP Low : $bp_sys/$bp_dias ,';
    } else if (bp_dias! > 80 && bp_sys! > 130) {
      print("Low Risk Alert: BP is HIGH");
      count = count + 1;
      alert_message += 'BP High : $bp_sys/$bp_dias ,';
    }
    if (sugar! < 70) {
      print("Low sugar level");
      count = count + 1;
      alert_message += 'Sugar Level Low : $sugar ,';
    } else if (sugar! > 180) {
      print("High sugar level");
      count = count + 1;
      alert_message += 'Sugar Level High : $sugar ,';
    }
    if (o2sat! < 95) {
      print("Low oxygen level");
      count = count + 1;
      alert_message += 'O2 sats Low : $o2sat ,';
    } else if (o2sat! > 100) {
      print("High o2 level");
      count = count + 1;
      alert_message += 'O2 sats High : $o2sat ,';
    }
    if (temp! < 96.8) {
      print("low Temperature");
      count = count + 1;
      alert_message += 'Temperature Low : $temp ,';
    } else if (temp! > 98.6) {
      print("High temperature");
      count = count + 1;
      alert_message += 'Temperature High : $temp ,';
    }

    //sugar
    if (activity! == 'low') {
      alert_message += 'Low Activity level ,';
      count = count + 1;
    }
    if (sleepcycle! == 'low' || sleepcycle! == 'high') {
      alert_message += 'Sleep cycle irregular : $sleepcycle,';
      count = count + 1;
    }
    if (foodintake! == 'low') {
      alert_message += 'Food intake Low,';
      count = count + 1;
    }
    if (waterintake! == 'low' || waterintake! == 'high') {
      alert_message += 'Abnormal Water Intake : $waterintake,';
      count = count + 1;
    }
    if (motion! == 'low' || motion! == 'high') {
      alert_message += 'Motion Ouput abnormal : $motion,';
      count = count + 1;
    }
    if (urine! == 'low' || urine == 'high') {
      count = count + 1;
      alert_message += 'Urine output abnormal : $urine,';
    }
    if (count <= 2) {
      print("There is no risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Low',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    } else if (count > 2 && count <= 5) {
      print("The condition is moderate level of risk :Alert to patient");
      print("The condition is moderate level of risk:Alert to doctor");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
      DocAlertModel docAlertModel = DocAlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now(),
          docId: id);
      DoctorServices doctorServices =
          DoctorServices(documentId: await fetchDocId(id));
      doctorServices.addalert_doc(docAlertModel, await fetchDocId(id));
    } else if (count > 5) {
      print("The condition is highly at risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'High',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    }
    //

    //
  }

  Future<void> findAlert_depression(String? id) async {
    int count = 0;
    String? alert_message = 'Existing Health Condition : Depression , ';
    //BP
    if (bp_dias! < 60 && bp_sys! < 90) {
      print("Low Risk Alert: BP is LOW");
      count = count + 1;
      alert_message += 'BP Low : $bp_sys/$bp_dias ,';
    } else if (bp_dias! > 80 && bp_sys! > 120) {
      print("Low Risk Alert: BP is HIGH");
      count = count + 1;
      alert_message += 'BP High : $bp_sys/$bp_dias ,';
    }
    if (sugar! < 70) {
      print("Low sugar level");
      count = count + 1;
      alert_message += 'Sugar Level Low : $sugar ,';
    } else if (sugar! > 100) {
      print("High sugar level");
      count = count + 1;
      alert_message += 'Sugar Level High : $sugar ,';
    }
    if (o2sat! < 95) {
      print("Low oxygen level");
      count = count + 1;
      alert_message += 'O2 sats Low : $o2sat ,';
    } else if (o2sat! > 100) {
      print("High o2 level");
      count = count + 1;
      alert_message += 'O2 sats High : $o2sat ,';
    }
    if (temp! < 96.8) {
      print("low Temperature");
      count = count + 1;
      alert_message += 'Temperature Low : $temp ,';
    } else if (temp! > 98.6) {
      print("High temperature");
      count = count + 1;
      alert_message += 'Temperature High : $temp ,';
    }

    //sugar
    if (activity! == 'low') {
      alert_message += 'Low Activity level ,';
      count = count + 1;
    }
    if (sleepcycle! == 'low' || sleepcycle! == 'high') {
      alert_message += 'Sleep cycle irregular : $sleepcycle,';
      count = count + 1;
    }
    if (foodintake! == 'low') {
      alert_message += 'Food intake Low,';
      count = count + 1;
    }
    if (waterintake! == 'low' || waterintake! == 'high') {
      alert_message += 'Abnormal Water Intake : $waterintake,';
      count = count + 1;
    }
    if (motion! == 'low' || motion! == 'high') {
      alert_message += 'Motion Ouput abnormal : $motion,';
      count = count + 1;
    }
    if (urine! == 'low' || urine == 'high') {
      count = count + 1;
      alert_message += 'Urine output abnormal : $urine,';
    }
    if (count <= 2) {
      print("There is no risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Low',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    } else if (count > 2 && count <= 5) {
      print("The condition is moderate level of risk :Alert to patient");
      print("The condition is moderate level of risk:Alert to doctor");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
      DocAlertModel docAlertModel = DocAlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now(),
          docId: id);
      DoctorServices doctorServices =
          DoctorServices(documentId: await fetchDocId(id));
      doctorServices.addalert_doc(docAlertModel, await fetchDocId(id));
    } else if (count > 5) {
      print("The condition is highly at risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'High',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    }
    //

    //
  }

  Future<void> findAlert_pulmonarydisease(String? id) async {
    int count = 0;
    String? alert_message = 'Existing Health Condition : Pulmonary Disease, ';
    //BP
    if (bp_dias! < 60 && bp_sys! < 90) {
      print("Low Risk Alert: BP is LOW");
      count = count + 1;
      alert_message += 'BP Low : $bp_sys/$bp_dias ,';
    } else if (bp_dias! > 80 && bp_sys! > 130) {
      print("Low Risk Alert: BP is HIGH");
      count = count + 1;
      alert_message += 'BP High : $bp_sys/$bp_dias ,';
    }
    if (sugar! < 70) {
      print("Low sugar level");
      count = count + 1;
      alert_message += 'Sugar Level Low : $sugar ,';
    } else if (sugar! > 140) {
      print("High sugar level");
      count = count + 1;
      alert_message += 'Sugar Level High : $sugar ,';
    }
    if (o2sat! < 90) {
      print("Low oxygen level");
      count = count + 1;
      alert_message += 'O2 sats Low : $o2sat ,';
    } else if (o2sat! > 95) {
      print("High o2 level");
      count = count + 1;
      alert_message += 'O2 sats High: $o2sat ,';
    }
    if (temp! < 96.8) {
      print("low Temperature");
      count = count + 1;
      alert_message += 'Temperature Low : $temp ,';
    } else if (temp! > 98.6) {
      print("High temperature");
      count = count + 1;
      alert_message += 'Temperature High : $temp ,';
    }

    //sugar
    if (activity! == 'low') {
      alert_message += 'Low Activity level ,';
      count = count + 1;
    }
    if (sleepcycle! == 'low' || sleepcycle! == 'high') {
      alert_message += 'Sleep cycle irregular : $sleepcycle,';
      count = count + 1;
    }
    if (foodintake! == 'low') {
      alert_message += 'Food intake Low,';
      count = count + 1;
    }
    if (waterintake! == 'low' || waterintake! == 'high') {
      alert_message += 'Abnormal Water Intake : $waterintake,';
      count = count + 1;
    }
    if (motion! == 'low' || motion! == 'high') {
      alert_message += 'Motion Ouput abnormal : $motion,';
      count = count + 1;
    }
    if (urine! == 'low' || urine == 'high') {
      count = count + 1;
      alert_message += 'Urine output abnormal : $urine,';
    }
    if (count <= 2) {
      print("There is no risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Low',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    } else if (count > 2 && count <= 5) {
      print("The condition is moderate level of risk :Alert to patient");
      print("The condition is moderate level of risk:Alert to doctor");
      AlertModel alertModel = AlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
      DocAlertModel docAlertModel = DocAlertModel(
          alert_nature: 'Moderate',
          alert_message: alert_message,
          timestamp: DateTime.now(),
          docId: id);
      DoctorServices doctorServices =
          DoctorServices(documentId: await fetchDocId(id));
      doctorServices.addalert_doc(docAlertModel, await fetchDocId(id));
    } else if (count > 5) {
      print("The condition is highly at risk :Alert to patient");
      AlertModel alertModel = AlertModel(
          alert_nature: 'High',
          alert_message: alert_message,
          timestamp: DateTime.now());
      DatabaseService databaseService = DatabaseService();
      databaseService.addalertdata(alertModel, id);
    }
  }

  Future<String?> fetchDocId(String? id) async {
    String? docId;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Signupdata')
        .doc(id)
        .collection('EmergencyInformation')
        .get();

    String? documentId = querySnapshot.docs.first.id;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('Signupdata')
        .doc(id)
        .collection('EmergencyInformation')
        .doc(documentId);

    DocumentSnapshot documentSnapshot = await documentReference.get();

    Map<String, dynamic>? data =
        documentSnapshot.data() as Map<String, dynamic>?;

    docId = data?['doctor'];
    return docId;
  }
}
