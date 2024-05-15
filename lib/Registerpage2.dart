// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:milena_patient/medicinedetails.dart';
import 'package:milena_patient/userdatacollect/healthmodel.dart';
import 'package:milena_patient/userdatacollect/services/databaseservice.dart';

class Registerpage2 extends StatefulWidget {
  String? signUpDataDocId;
  Registerpage2(String? signupdataid) {
    signUpDataDocId = signupdataid;
  }

  @override
  State<Registerpage2> createState() => _Registerpage2State(signUpDataDocId);
}

class _Registerpage2State extends State<Registerpage2> {
  String? signUpDataDocId = '';
  final TextEditingController _heightcontroller = TextEditingController();

  final TextEditingController _weightcontroller = TextEditingController();

  final TextEditingController _exhealthcontroller = TextEditingController();

  final TextEditingController _prevsurgerycontroller = TextEditingController();

  final TextEditingController _currdoccontroller = TextEditingController();

  @override
  void dispose() {
    _currdoccontroller.dispose();
    _exhealthcontroller.dispose();
    _heightcontroller.dispose();
    _prevsurgerycontroller.dispose();
    _weightcontroller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  _Registerpage2State(String? signupdocid) {
    signUpDataDocId = signupdocid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Health Information',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500))),
        body: SafeArea(
          child: SingleChildScrollView(
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
                        controller: _heightcontroller,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          hintStyle: TextStyle(fontStyle: FontStyle.normal),
                          hintText: 'Height',
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
                        controller: _weightcontroller,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          hintStyle: TextStyle(fontStyle: FontStyle.normal),
                          hintText: 'Weight',
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
                        controller: _exhealthcontroller,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          hintStyle: TextStyle(fontStyle: FontStyle.normal),
                          hintText: 'Existing Health Conditions',
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
                        controller: _prevsurgerycontroller,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          hintStyle: TextStyle(fontStyle: FontStyle.normal),
                          hintText: 'Any Previous Surgeries',
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
                        controller: _currdoccontroller,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          hintStyle: TextStyle(fontStyle: FontStyle.normal),
                          hintText: 'Currently Consulting Doctor',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _reg_page_2(context),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: const Icon(Icons.arrow_circle_right),
        ));
  }

  void _reg_page_2(BuildContext context) {
    int? Height;
    int? Weight;
    String? ex_health_conditions = _exhealthcontroller.text;
    String? prev_surgery = _prevsurgerycontroller.text;
    String? curr_doctor = _currdoccontroller.text;

    try {
      Height = int.parse(_heightcontroller.text);
      Weight = int.parse(_weightcontroller.text);
    } catch (e) {
      // Handle parsing errors
      print('Error parsing height or weight: $e');
      // You can show a snackbar or dialog to inform the user about the error
      return; // Exit the method early if parsing fails
    }

    HealthModel newHealth = HealthModel(
        Height: Height,
        Weight: Weight,
        ex_health_conditions: ex_health_conditions,
        prev_surgery: prev_surgery,
        curr_doctor: curr_doctor);

    DatabaseService databaseService = DatabaseService();
    databaseService.addhealthdata(newHealth, signUpDataDocId);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MedicineDetails(signUpDataDocId: signUpDataDocId)));
  }
}
