import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewDocAlert extends StatefulWidget {
  final String? id;

  const ViewDocAlert({required this.id});

  @override
  State<ViewDocAlert> createState() => _ViewDocAlertState(id: id);
}

class _ViewDocAlertState extends State<ViewDocAlert> {
  String? message;
  String? id;
  void initState() {
    super.initState();
    fetchDoctorReply(
        id); // Call fetchpatientDetails() method when the widget is initialized
  }

  _ViewDocAlertState({required this.id});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            title: Text(
              'View Doctor\'s Message',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Alert Message: ',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500, fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      width: 370,
                      height: 500,
                      color: Colors.blue[50],
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          '$message',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Ok',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
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

  Future<void> fetchDoctorReply(String? id) async {
    String? docId = await fetchDocId(id);
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection('Dr.signup')
        .doc(docId)
        .collection('Alerts');
    QuerySnapshot querySnapshot = await collectionReference.get();
    String? alertdocumentid = querySnapshot.docs.first.id;

    DocumentReference documentReference =
        collectionReference.doc(alertdocumentid);

    DocumentSnapshot documentSnapshot = await documentReference.get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    setState(() {
      if (data['Reply_from_Doctor'] != null) {
        message = data['Reply_from_Doctor'];
      } else {
        message = 'No reply yet. Please wait.';
      }
    });
  }
}
