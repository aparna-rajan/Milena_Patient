import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Edit Profile',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w500))),
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
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        hintStyle: TextStyle(fontStyle: FontStyle.normal),
                        hintText: 'Change Password',
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        alignment: Alignment.center),
                  )),
                ),
              ],
            )),
      ),
    );
  }
}
