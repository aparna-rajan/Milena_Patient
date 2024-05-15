// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milena_patient/Registerpage2.dart';
import 'package:milena_patient/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:milena_patient/userdatacollect/services/databaseservice.dart';
import 'package:milena_patient/userdatacollect/signupmodel.dart';

class Registerpage1 extends StatefulWidget {
  Registerpage1({super.key});

  @override
  State<Registerpage1> createState() => _Registerpage1State();
}

class _Registerpage1State extends State<Registerpage1> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  //final TextEditingController? controller=null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Register with Us',
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
                          controller: _nameController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            hintStyle: TextStyle(fontStyle: FontStyle.normal),
                            hintText: 'Name of the Patient',
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
                          controller: _ageController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            hintStyle: TextStyle(fontStyle: FontStyle.normal),
                            hintText: 'Age',
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
                          controller: _genderController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            hintStyle: TextStyle(fontStyle: FontStyle.normal),
                            hintText: 'Gender',
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
                          controller: _addressController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            hintStyle: TextStyle(fontStyle: FontStyle.normal),
                            hintText: 'Address',
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
                          controller: _phoneController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            hintStyle: TextStyle(fontStyle: FontStyle.normal),
                            hintText: 'Phone Number',
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
                          controller: _emailController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            hintStyle: TextStyle(fontStyle: FontStyle.normal),
                            hintText: 'Email id (for login)',
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
                          obscureText: true,
                          controller: _passwordController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            hintStyle: TextStyle(fontStyle: FontStyle.normal),
                            hintText: 'Create a Password',
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
                          obscureText: true,
                          controller: _confirmPassController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30)),
                            hintStyle: TextStyle(fontStyle: FontStyle.normal),
                            hintText: 'Confirm Your Password',
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _signUp,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          child: const Icon(Icons.arrow_circle_right),
        ));
  }

  void _signUp() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    int age = int.parse(_ageController.text);
    String gender = _genderController.text;
    String address = _addressController.text;
    int phoneNumber = int.parse(_phoneController.text);

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print('User Created');

      String? userId;
      UserModel newUser = UserModel(
        Name: name,
        Age: age,
        Gender: gender,
        Address: address,
        Email: email,
        PhoneNumber: phoneNumber,
      );

      DatabaseService databaseService = DatabaseService();
      userId = await databaseService.addsignupdata(newUser);

      print(userId);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Registerpage2(userId)),
      );
    } else {
      print('Some error occurred');
    }
  }
}
