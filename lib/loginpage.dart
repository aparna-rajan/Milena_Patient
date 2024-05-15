import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milena_patient/Registerpage1.dart';
import 'package:milena_patient/forgetpassword.dart';
import 'package:milena_patient/homepage.dart';
import 'package:milena_patient/user_auth/firebase_auth_implementation/firebase_auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: SizedBox(
                    height: 150,
                    child: Image(image: AssetImage('assets/LOGO.png')),
                  ),
                ),
                Text(
                  'Login to your Account',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    controller: _emailController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      hintText: 'Email',
                      hintStyle: TextStyle(fontStyle: FontStyle.normal),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        controller: _passwordController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintStyle: TextStyle(fontStyle: FontStyle.normal),
                          hintText: 'Password',
                        ),
                        obscureText: true,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: TextButton(
                    onPressed: _signIn,
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Login'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Registerpage1(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    if (user != null) {
      print('Sign In');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      print('Some error occurred');
    }
  }
}
