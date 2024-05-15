import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milena_patient/Registerpage1.dart';
import 'package:milena_patient/loginpage.dart';

class Getyoustarted extends StatelessWidget {
  const Getyoustarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 400,
                  width: 500,
                  child:
                      Image(image: AssetImage('assets/Humaaans Wireframe.png')),
                ),
              ),
              Center(
                child: Text(
                  "Let's Get you in",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 50,
                    width: 280,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        'Login with password',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                    ),
                  ),
                ),
              ),
              Expanded(
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
                                      builder: (context) => Registerpage1()));
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ]),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
