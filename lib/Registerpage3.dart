import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milena_patient/loginpage.dart';
import 'package:milena_patient/userdatacollect/emergencymodel.dart';
import 'package:milena_patient/userdatacollect/services/databaseservice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Registerpage3 extends StatefulWidget {
  final String? signUpDataDocId;

  const Registerpage3({super.key, required this.signUpDataDocId});

  @override
  _Registerpage3State createState() => _Registerpage3State();
}

Doctor? dropdownValue;

class Doctor {
  final String? name;
  final String? specialization;

  Doctor({required this.name, required this.specialization});

  // Override hashCode and operator== to ensure uniqueness
  @override
  int get hashCode => name.hashCode ^ specialization.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Doctor &&
        other.name == name &&
        other.specialization == specialization;
  }
}

class _Registerpage3State extends State<Registerpage3> {
  String dropdownvalue = 'Select Doctor';
  String? signUpDataDocId = '';
  Doctor? dropdownValue;
  List<DocumentSnapshot> doctorSnapshots = [];

  @override
  void initState() {
    super.initState();
    fetchDoctors(); // Call fetchDoctors method when the widget initializes
  }

  void fetchDoctors() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('Dr.signup').get();
      setState(() {
        doctorSnapshots = snapshot.docs;
      });
    } catch (e) {
      print('Error fetching doctors: $e');
    }
  }

  final TextEditingController _emerContact1 = TextEditingController();
  final TextEditingController _emerContact2 = TextEditingController();
  final TextEditingController _prefHealthCentre = TextEditingController();

  @override
  void dispose() {
    _emerContact1.dispose();
    _emerContact2.dispose();
    _prefHealthCentre.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Some more Information...',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _emerContact1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        hintStyle: const TextStyle(fontStyle: FontStyle.normal),
                        hintText: 'Emergency Contact 1',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _emerContact2,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        hintStyle: const TextStyle(fontStyle: FontStyle.normal),
                        hintText: 'Emergency Contact 2',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _prefHealthCentre,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        hintStyle: const TextStyle(fontStyle: FontStyle.normal),
                        hintText: 'Preferred Nearby Health Centre',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                Center(
                  child: SizedBox(
                      width: 350,
                      child: Text(
                        'Choose a doctor from our System to assist you',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            fontStyle: FontStyle.italic),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 350,
                    child: DropdownButton(
                      value: dropdownValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                      items: doctorSnapshots.map((doc) {
                        Map<String, dynamic> data =
                            doc.data() as Map<String, dynamic>;
                        return DropdownMenuItem(
                          value: Doctor(
                            name: data['name'],
                            specialization: data['specialization'],
                          ),
                          child: Text(
                              '${data['name']} - ${data['specialization']}'),
                        );
                      }).toList(),
                      onChanged: (Doctor? newValue) {
                        setState(() {
                          dropdownValue = Doctor(
                              name: newValue?.name,
                              specialization: newValue?.specialization);
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(60),
                  child: Center(
                    child: SizedBox(
                      width: 300,
                      height: 50,
                      child: TextButton(
                        onPressed: _emergencyReg,
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text('Complete SignUp'),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Future<void> _emergencyReg() async {
    int? emergencyContact1;
    int? emergencyContact2;
    String? preferredHospital = _prefHealthCentre.text;
    String? doctor = dropdownValue?.name;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('Dr.signup')
        .where('name', isEqualTo: doctor)
        .get();

    String? id = querySnapshot.docs.first.id;

    try {
      emergencyContact1 = int.parse(_emerContact1.text);
      emergencyContact2 = int.parse(_emerContact2.text);
    } catch (e) {
      print('Exception at Emergency contact parsing');
    }

    if (doctor != null) {
      EmergencyModel emergencyModel = EmergencyModel(
          emergencyContact1: emergencyContact1,
          emergencyContact2: emergencyContact2,
          preferredHospital: preferredHospital,
          doctor: id);

      print(signUpDataDocId);
      DatabaseService databaseService = DatabaseService();
      databaseService.addemerdata(emergencyModel, widget.signUpDataDocId);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      print('No doctor selected');
      // Handle the case where no doctor is selected
    }
  }
}
