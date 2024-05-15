import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milena_patient/adddailydata.dart';
import 'package:milena_patient/alertsmanagement/doctor_alertmodel.dart';
import 'package:milena_patient/userdatacollect/services/databaseservice.dart';
import 'package:milena_patient/userdatacollect/services/doctor_Services.dart';
import 'package:milena_patient/viewalert.dart';
import 'package:milena_patient/viewdoctorsalert.dart';

class MainHome extends StatefulWidget {
  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  String? id;
  TextEditingController significantcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: fetchDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()); // Or any loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          // Data fetched successfully
          String name = snapshot.data?['Name'] ?? '';
          // Now you can use the name variable to display the name in your UI
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              automaticallyImplyLeading: true,
              title: Text(
                'Home',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 40, right: 20, left: 20, bottom: 30),
                      child: SizedBox(
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Hi $name",
                                      style: GoogleFonts.poppins(
                                          fontSize: 30,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 8, top: 10),
                                    child: SizedBox(
                                      width: 180,
                                      height: 120,
                                      child: Text(
                                        "Hope you are doing well. Milena is here to help you. Please feed your daily information. ",
                                        style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Image(
                                image: AssetImage('assets/LOGO.png'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            child: Text(
                              'Any Significant Symptoms?',
                              style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: 300,
                                  child: TextFormField(
                                    controller: significantcontroller,
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Feed Significant Symptom',
                                        hintStyle: TextStyle(
                                            fontStyle: FontStyle.italic)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: TextButton(
                                    onPressed: () {
                                      feedsignificantsymptom();
                                      setState(() {
                                        significantcontroller.clear();
                                      });
                                    },
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, right: 10, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(children: [
                              SizedBox(
                                  height: 100,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddDailyData()));
                                      },
                                      icon: Image(
                                        image: AssetImage(
                                            'assets/medical-record.png'),
                                        color: Colors.blue,
                                      ))),
                              Text('Add Daily \nData',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500))
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 10),
                            child: Column(children: [
                              SizedBox(
                                height: 100,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewAlert(id: id)));
                                  },
                                  icon: Image(
                                    image: AssetImage('assets/mark.png'),
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Text('View\nAlerts',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500))
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(children: [
                              SizedBox(
                                height: 100,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewDocAlert(
                                                    id: id,
                                                  )));
                                    },
                                    icon: Image(
                                      image: AssetImage(
                                          'assets/medical-assistance.png'),
                                      color: Colors.blue,
                                    )),
                              ),
                              Text("View Doctor's\nAlerts",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500))
                            ]),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future<DocumentSnapshot> fetchDetails() async {
    String? emailId = FirebaseAuth.instance.currentUser?.email;

    if (emailId != null) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('Signupdata')
              .where('Email', isEqualTo: emailId)
              .get();
      id = querySnapshot.docs.first.id;
    } else {
      id = '';
      print('Empty email');
    }

    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('Signupdata')
          .doc(id)
          .get();

      return documentSnapshot;
    } catch (e) {
      print('Error getting data from document $id: $e');
      throw e; // Rethrow the error to handle it in the UI
    }
  }

  Future<void> feedsignificantsymptom() async {
    String? emailId = FirebaseAuth.instance.currentUser?.email;
    String? symptom = significantcontroller.text;
    if (emailId != null) {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('Signupdata')
              .where('Email', isEqualTo: emailId)
              .get();
      id = querySnapshot.docs.first.id;
    } else {
      id = '';
      print('Empty email');
    }
    DatabaseService databaseService = DatabaseService();
    databaseService.addsignificantsymptom(symptom, id);

    DocAlertModel docAlertModel = DocAlertModel(
        alert_nature: 'Significant Symptom',
        alert_message: symptom,
        timestamp: DateTime.now(),
        docId: id);
    DoctorServices doctorServices =
        DoctorServices(documentId: await fetchDocId(id));
    doctorServices.addalert_doc_significantSymptom(
        docAlertModel, await fetchDocId(id));
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
