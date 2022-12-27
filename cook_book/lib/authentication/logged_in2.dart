
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/app/loginpage/loginPage.dart';
import 'package:cook_book/authentication/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';

class LoggedInWidget2 extends StatefulWidget{
  const LoggedInWidget2({super.key});

  @override
  LoggedInWidgetState2 createState() => LoggedInWidgetState2();
}
class LoggedInWidgetState2 extends State<LoggedInWidget2> {
  final ref = FirebaseDatabase.instance.ref('users');
  final user = FirebaseAuth.instance.currentUser;
  final googleSignIn = GoogleSignIn();
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged In'),
        centerTitle: true,
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: () {
              logout(context);
            },
            child: const Text('Logout'),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Profile',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 32),
            /*CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(photo),
              ),*/
            const SizedBox(height: 8),
            Text(
              'Name: ${loggedInUser.name!}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Email: ${loggedInUser.email!}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> logout(BuildContext context) async {
    await googleSignIn.currentUser?.clearAuthCache();
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
        Fluttertoast.showToast(msg: "Logged Out Successfully.");
  }
}


