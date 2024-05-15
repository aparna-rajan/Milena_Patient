import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milena_patient/editprofile.dart';
import 'package:milena_patient/loginpage.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name;

  int? phone;

  String? address;

  String? email;
  Map<String, dynamic>? data;
  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: Text(
          'Profile',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 5),
                          color: Color.fromARGB(255, 125, 153, 223)
                              .withOpacity(.2),
                          spreadRadius: 2,
                          blurRadius: 10)
                    ]),
                child: ListTile(
                  title: Text('Name'),
                  subtitle: Text(name.toString()),
                  leading: Icon(Icons.person),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 5),
                          color: Color.fromARGB(255, 125, 153, 223)
                              .withOpacity(.2),
                          spreadRadius: 2,
                          blurRadius: 10)
                    ]),
                child: ListTile(
                  title: Text('Phone'),
                  subtitle: Text(phone.toString()),
                  leading: Icon(Icons.phone),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 5),
                          color: Color.fromARGB(255, 125, 153, 223)
                              .withOpacity(.2),
                          spreadRadius: 2,
                          blurRadius: 10)
                    ]),
                child: ListTile(
                  title: Text('Address'),
                  subtitle: Text(address.toString()),
                  leading: Icon(Icons.location_city),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 5),
                          color: Color.fromARGB(255, 125, 153, 223)
                              .withOpacity(.2),
                          spreadRadius: 2,
                          blurRadius: 10)
                    ]),
                child: ListTile(
                  title: Text('Email'),
                  subtitle: Text(email.toString()),
                  leading: Icon(Icons.email),
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditProfile()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.all(15),
                          ),
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.all(15),
                          ),
                          child: const Text(
                            'Sign Out',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> fetchDetails() async {
    String? emailId = FirebaseAuth.instance.currentUser?.email;

    String id;
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

      if (documentSnapshot.exists) {
        data = documentSnapshot.data() as Map<String, dynamic>?;
        setState(() {
          name = data?['Name'];
          phone = data?['PhoneNumber'];
          address = data?['Address'];
          email = data?['Email'];
        });
        print('Data in document $id: ${documentSnapshot.data()}');
      } else {
        print('Document $id does not exist');
      }
    } catch (e) {
      print('Error getting data from document $id: $e');
    }
  }
}
