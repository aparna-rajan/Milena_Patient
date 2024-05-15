import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milena_patient/alertsmanagement/alerts.dart';
import 'package:milena_patient/userdatacollect/dailydatamodel.dart';
import 'package:milena_patient/userdatacollect/services/databaseservice.dart';

class AddDailyData extends StatefulWidget {
  AddDailyData({super.key});

  @override
  State<AddDailyData> createState() => _AddDailyDataState();
}

class _AddDailyDataState extends State<AddDailyData> {
  TextEditingController bp_sys_controller = TextEditingController();

  TextEditingController bp_dias_controller = TextEditingController();

  TextEditingController temp_controller = TextEditingController();

  TextEditingController sugar_controller = TextEditingController();

  TextEditingController o2sat_controller = TextEditingController();

  TextEditingController activity_controller = TextEditingController();

  TextEditingController sleep_controller = TextEditingController();

  TextEditingController food_controller = TextEditingController();

  TextEditingController water_controller = TextEditingController();

  TextEditingController motion_controller = TextEditingController();

  TextEditingController urine_controller = TextEditingController();

  Color buttonColor1 = Colors.blue;
  Color buttonColor2 = Colors.blue;
  Color buttonColor3 = Colors.blue;
  Color buttonColor4 = Colors.blue;
  Color buttonColor5 = Colors.blue;
  Color buttonColor6 = Colors.blue;
  Color buttonColor7 = Colors.blue;
  Color buttonColor8 = Colors.blue;
  Color buttonColor9 = Colors.blue;

  Color buttonColor10 = Colors.blue;
  Color buttonColor11 = Colors.blue;
  Color buttonColor12 = Colors.blue;
  Color buttonColor13 = Colors.blue;
  Color buttonColor14 = Colors.blue;
  Color buttonColor15 = Colors.blue;
  Color buttonColor16 = Colors.blue;
  Color buttonColor17 = Colors.blue;
  Color buttonColor18 = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: Text(
          'Add Daily Data',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10.0, left: 20, right: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Blood Pressure',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 170,
                                child: TextFormField(
                                  controller: bp_sys_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle:
                                        TextStyle(fontStyle: FontStyle.normal),
                                    hintText: 'Systolic',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width: 10,
                                    child: Text(
                                      '/',
                                      style: TextStyle(fontSize: 30),
                                    )),
                              ),
                              SizedBox(
                                width: 170,
                                child: TextFormField(
                                  controller: bp_dias_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    hintStyle:
                                        TextStyle(fontStyle: FontStyle.normal),
                                    hintText: 'Diastolic',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Temperature',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: temp_controller,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          hintStyle: TextStyle(fontStyle: FontStyle.normal),
                          hintText: 'Enter Temperature',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Sugar Level',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: sugar_controller,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          hintStyle: TextStyle(fontStyle: FontStyle.normal),
                          hintText: 'Enter Sugar Level',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Oxygen Saturation',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: o2sat_controller,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          hintStyle: TextStyle(fontStyle: FontStyle.normal),
                          hintText: 'Enter Oxygen Saturation Level',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Activity Status: ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text(
                            'How active is the patient? (eg:able to talk,walk etc.)',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor1,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                activity_controller.text = 'low';
                                setState(() {
                                  buttonColor1 = Colors.black;
                                });
                              },
                              child: Text(
                                'Low',
                                style: TextStyle(fontSize: 18),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor2,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                activity_controller.text = 'moderate';
                                setState(() {
                                  buttonColor2 = Colors.black;
                                });
                              },
                              child: Text(
                                'Moderate',
                                style: TextStyle(fontSize: 18),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor3,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                activity_controller.text = 'high';
                                setState(() {
                                  buttonColor3 = Colors.black;
                                });
                              },
                              child: Text(
                                'High',
                                style: TextStyle(fontSize: 18),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sleep Cycle:',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text('Is the patient getting enough sleep?',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor4,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                sleep_controller.text = 'low';
                                setState(() {
                                  buttonColor4 = Colors.black;
                                });
                              },
                              child: Text(
                                'Low',
                                style: TextStyle(fontSize: 18),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor5,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                sleep_controller.text = 'moderate';
                                setState(() {
                                  buttonColor5 = Colors.black;
                                });
                              },
                              child: Text(
                                'Moderate',
                                style: TextStyle(fontSize: 18),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor6,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                sleep_controller.text = 'high';
                                setState(() {
                                  buttonColor6 = Colors.black;
                                });
                              },
                              child: Text(
                                'High',
                                style: TextStyle(fontSize: 18),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: .0),
                        child: Text(
                          'Food Intake',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text('How much is the food intake level?',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor7,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                food_controller.text = 'low';
                                setState(() {
                                  buttonColor7 = Colors.black;
                                });
                              },
                              child: Text(
                                'Low',
                                style: TextStyle(fontSize: 18),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor8,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                food_controller.text = 'moderate';
                                setState(() {
                                  buttonColor8 = Colors.black;
                                });
                              },
                              child: Text(
                                'Moderate',
                                style: TextStyle(fontSize: 18),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor9,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                food_controller.text = 'high';
                                setState(() {
                                  buttonColor9 = Colors.black;
                                });
                              },
                              child: Text(
                                'High',
                                style: TextStyle(fontSize: 18),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Water Intake',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text('Has the patient had enough water today?',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor10,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                water_controller.text = 'low';
                                setState(() {
                                  buttonColor10 = Colors.black;
                                });
                              },
                              child: Text(
                                'Low',
                                style: TextStyle(fontSize: 18),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor11,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                water_controller.text = 'moderate';
                                setState(() {
                                  buttonColor11 = Colors.black;
                                });
                              },
                              child: Text(
                                'Moderate',
                                style: TextStyle(fontSize: 18),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor12,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                water_controller.text = 'high';
                                setState(() {
                                  buttonColor12 = Colors.black;
                                });
                              },
                              child: Text(
                                'High',
                                style: TextStyle(fontSize: 18),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Motion',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text('Has the patient passed stools today?',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor13,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                motion_controller.text = 'low';
                                setState(() {
                                  buttonColor13 = Colors.black;
                                });
                              },
                              child: Text(
                                'Low',
                                style: TextStyle(fontSize: 18),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor14,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                motion_controller.text = 'moderate';
                                setState(() {
                                  buttonColor14 = Colors.black;
                                });
                              },
                              child: Text(
                                'Moderate',
                                style: TextStyle(fontSize: 18),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor15,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                motion_controller.text = 'high';
                                setState(() {
                                  buttonColor15 = Colors.black;
                                });
                              },
                              child: Text(
                                'High',
                                style: TextStyle(fontSize: 18),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 30),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          'Urine Output',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text('Has there been enough urine output today?',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor16,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                urine_controller.text = 'low';
                                setState(() {
                                  buttonColor16 = Colors.black;
                                });
                              },
                              child: Text(
                                'Low',
                                style: TextStyle(fontSize: 18),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor17,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                urine_controller.text = 'moderate';
                                setState(() {
                                  buttonColor17 = Colors.black;
                                });
                              },
                              child: Text(
                                'Moderate',
                                style: TextStyle(fontSize: 18),
                              )),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor18,
                                  foregroundColor: Colors.white),
                              onPressed: () {
                                urine_controller.text = 'high';
                                setState(() {
                                  buttonColor18 = Colors.black;
                                });
                              },
                              child: Text(
                                'High',
                                style: TextStyle(fontSize: 18),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => _dailydatafeed(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Icon(
                  Icons.done,
                  size: 40,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _dailydatafeed(BuildContext context) async {
    int? bp_sys;
    int? bp_dias;
    double? temp;
    int? sugar;
    int? o2sat;
    String? activity = activity_controller.text;
    String? sleepcycle = sleep_controller.text;
    String? foodintake = food_controller.text;
    String? waterintake = water_controller.text;
    String? motion = motion_controller.text;
    String? urine = urine_controller.text;

    try {
      bp_sys = int.parse(bp_sys_controller.text);
      bp_dias = int.parse(bp_dias_controller.text);
      sugar = int.parse(sugar_controller.text);
      o2sat = int.parse(o2sat_controller.text);
      temp = double.parse(temp_controller.text);
    } catch (e) {
      // Handle parsing errors
      print('Error parsing height or weight: $e');
      // You can show a snackbar or dialog to inform the user about the error
      return; // Exit the method early if parsing fails
    }
    String? id;
    DatabaseService databaseService = DatabaseService();
    DailyDataModel dailyDataModel = DailyDataModel(
        bp_sys: bp_sys,
        bp_dias: bp_dias,
        temp: temp,
        sugar: sugar,
        o2sat: o2sat,
        activity: activity,
        sleepcycle: sleepcycle,
        foodintake: foodintake,
        waterintake: waterintake,
        motion: motion,
        urine: urine);
    String? email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('Signupdata')
              .where('Email', isEqualTo: email)
              .get();
      id = querySnapshot.docs.first.id;

      databaseService.adddailydata(dailyDataModel, id);
    } else {
      print('Empty email');
    }

    String? healthid = await databaseService.getHealthInfoDocId(id);
    String? healthcond =
        await databaseService.getExistingHealthConditions(id, healthid);
    Alerts alerts = Alerts(dailyDataModel, id);

    alerts.findAlert(healthcond, id);

    Navigator.pop(context);
  }
}
