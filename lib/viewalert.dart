import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ViewAlert extends StatefulWidget {
  final String? id;

  ViewAlert({required this.id});

  @override
  _ViewAlertState createState() => _ViewAlertState();
}

class _ViewAlertState extends State<ViewAlert> {
  String? date;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: Text(
            'View Alert',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
        ),
        body: FutureBuilder(
          future: fetchMostRecentAlertDetails(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          'Alert Message: ',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 8, right: 8),
                        child: Container(
                          width: double.maxFinite,
                          height: 500,
                          color: Colors.blue[50],
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              '${snapshot.data?['alertNature']} Risk Alert: \n\nTime of alert : $date \n\n${snapshot.data?['alertMessage']}',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
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
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<Map<String, dynamic>> fetchMostRecentAlertDetails(String? id) async {
    try {
      print('Fetching alerts...');
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('Signupdata')
              .doc(id)
              .collection('Alerts')
              .orderBy('timestamp', descending: true)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        String? alertId = querySnapshot.docs.first.id;
        print('Alert ID: $alertId');

        DocumentReference documentReference = FirebaseFirestore.instance
            .collection('Signupdata')
            .doc(id)
            .collection('Alerts')
            .doc(alertId);

        DocumentSnapshot snapshot = await documentReference.get();

        if (snapshot.exists) {
          Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

          if (data != null) {
            final alertMessage = data['alert_message'];
            final alertNature = data['alert_nature'];
            final Timestamp time = data['timestamp'];
            DateTime dateTime = time.toDate();
            date =
                '${dateTime.hour}:${dateTime.minute} (${dateTime.day}-${dateTime.month}-${dateTime.year})';

            if (alertNature != null && alertMessage != null) {
              if (alertNature == 'Moderate') {
                return {
                  'alertMessage':
                      'This is a moderate risk situation. The doctor has been notified about it. Please wait for the notification from the doctor.',
                  'alertNature': alertNature,
                  'timestamp': time,
                };
              } else if (alertNature == 'High') {
                return {
                  'alertMessage':
                      'This is a High risk situation. We advise you to consult the nearest health care centre as soon as possible    .',
                  'alertNature': alertNature,
                  'timestamp': time,
                };
              } else if (alertNature == 'Low') {
                return {
                  'alertMessage':
                      'This is a Low risk situation.The patient is safe.',
                  'alertNature': alertNature,
                  'timestamp': time,
                };
              }
            } else {
              return {
                'alertMessage': null,
                'alertNature': null,
                'timestamp': time,
              };
            }
          }
        }
      } else {
        print('No alerts found.');
      }
    } catch (e, stackTrace) {
      print('Error fetching most recent alert: $e');
      print('Stack trace: $stackTrace');
      throw (e);
    }
    return {
      'alertMessage': null,
      'alertNature': null,
    };
  }
}
