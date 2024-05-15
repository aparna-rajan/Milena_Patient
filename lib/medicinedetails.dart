// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, avoid_unnecessary_containers, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milena_patient/Registerpage3.dart';
import 'package:milena_patient/userdatacollect/medicinemodel.dart';
import 'package:milena_patient/userdatacollect/services/databaseservice.dart';

class MedicineDetails extends StatefulWidget {
  final String? signUpDataDocId;

  const MedicineDetails({Key? key, required this.signUpDataDocId})
      : super(key: key);

  @override
  State<MedicineDetails> createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  String? signUpDataDocId = '';
  final TextEditingController _medNameController1 = TextEditingController();
  final TextEditingController _dosageController1 = TextEditingController();
  final TextEditingController _timingController1 = TextEditingController();
  final TextEditingController _bafoodController1 = TextEditingController();
  final TextEditingController _medNameController2 = TextEditingController();
  final TextEditingController _dosageController2 = TextEditingController();
  final TextEditingController _timingController2 = TextEditingController();
  final TextEditingController _bafoodController2 = TextEditingController();
  final TextEditingController _medNameController3 = TextEditingController();
  final TextEditingController _dosageController3 = TextEditingController();
  final TextEditingController _timingController3 = TextEditingController();
  final TextEditingController _bafoodController3 = TextEditingController();
  final TextEditingController _medNameController4 = TextEditingController();
  final TextEditingController _dosageController4 = TextEditingController();
  final TextEditingController _timingController4 = TextEditingController();
  final TextEditingController _bafoodController4 = TextEditingController();
  final TextEditingController _medNameController5 = TextEditingController();
  final TextEditingController _dosageController5 = TextEditingController();
  final TextEditingController _timingController5 = TextEditingController();
  final TextEditingController _bafoodController5 = TextEditingController();
  @override
  void dispose() {
    _bafoodController1.dispose();
    _dosageController1.dispose();
    _timingController1.dispose();
    _medNameController1.dispose();
    _bafoodController2.dispose();
    _dosageController2.dispose();
    _timingController2.dispose();
    _medNameController2.dispose();
    _bafoodController3.dispose();
    _dosageController3.dispose();
    _timingController3.dispose();
    _medNameController3.dispose();
    _bafoodController4.dispose();
    _dosageController4.dispose();
    _timingController4.dispose();
    _medNameController4.dispose();
    _bafoodController5.dispose();
    _dosageController5.dispose();
    _timingController5.dispose();
    _medNameController5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Medicine Details',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
            ),
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              'Medicine :',
                              style: GoogleFonts.poppins(
                                  fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _medNameController1,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText: 'Enter Medicine Name',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _dosageController1,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText: 'Enter Dosage',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _timingController1,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText:
                                  'Enter Timing (Morning, Afternoon, Night)',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _bafoodController1,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText: 'Before Food or After Food',
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              'Medicine :',
                              style: GoogleFonts.poppins(
                                  fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _medNameController2,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText: 'Enter Medicine Name',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _dosageController2,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText: 'Enter Dosage',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _timingController2,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText:
                                  'Enter Timing (Morning, Afternoon, Night)',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _bafoodController2,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText: 'Before Food or After Food',
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              'Medicine :',
                              style: GoogleFonts.poppins(
                                  fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _medNameController3,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText: 'Enter Medicine Name',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _dosageController3,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText: 'Enter Dosage',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _timingController3,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText:
                                  'Enter Timing (Morning, Afternoon, Night)',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _bafoodController3,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText: 'Before Food or After Food',
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              'Medicine :',
                              style: GoogleFonts.poppins(
                                  fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _medNameController4,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText: 'Enter Medicine Name',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _dosageController4,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText: 'Enter Dosage',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _timingController4,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText:
                                  'Enter Timing (Morning, Afternoon, Night)',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _bafoodController4,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText: 'Before Food or After Food',
                            )),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue),
                          child: Center(
                            child: Text(
                              'Medicine :',
                              style: GoogleFonts.poppins(
                                  fontSize: 20, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _medNameController5,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText: 'Enter Medicine Name',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _dosageController5,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText: 'Enter Dosage',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _timingController5,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText:
                                  'Enter Timing (Morning, Afternoon, Night)',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            controller: _bafoodController5,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              hintStyle: TextStyle(fontStyle: FontStyle.normal),
                              hintText: 'Before Food or After Food',
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _medpage(context),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            child: const Icon(Icons.arrow_circle_right),
          )),
    );
  }

  void _medpage(BuildContext context) {
    final DatabaseService databaseService = DatabaseService();

    // List of all medication models
    final List<MedicineModel> medicineModels = [
      _createMedicineModel(_medNameController1, _dosageController1,
          _timingController1, _bafoodController1),
      _createMedicineModel(_medNameController2, _dosageController2,
          _timingController2, _bafoodController2),
      _createMedicineModel(_medNameController3, _dosageController3,
          _timingController3, _bafoodController3),
      _createMedicineModel(_medNameController4, _dosageController4,
          _timingController4, _bafoodController4),
      _createMedicineModel(_medNameController5, _dosageController5,
          _timingController5, _bafoodController5),
    ];

    // Filter out empty medication models
    final List<MedicineModel> nonEmptyMedicineModels =
        medicineModels.where((model) => model.medName!.isNotEmpty).toList();

    // Add each non-empty medication model to the database
    nonEmptyMedicineModels.forEach((model) {
      databaseService.addmeddata(model, widget.signUpDataDocId);
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Registerpage3(signUpDataDocId: widget.signUpDataDocId)));
  }

  MedicineModel _createMedicineModel(
      TextEditingController medNameController,
      TextEditingController dosageController,
      TextEditingController timingController,
      TextEditingController bafoodController) {
    return MedicineModel(
      medName: medNameController.text.trim(),
      dosage: dosageController.text.trim(),
      timing: timingController.text.trim(),
      ba_food: bafoodController.text.trim(),
    );
  }
}
