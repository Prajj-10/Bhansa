
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/authentication/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';

class LoggedInWidget extends StatefulWidget{
  const LoggedInWidget({super.key});

  @override
    LoggedInWidgetState createState() => LoggedInWidgetState();
}
class LoggedInWidgetState extends State<LoggedInWidget> {
  final ref = FirebaseDatabase.instance.ref('users');
  final user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  var name;
  var email;
  var photo;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value){
      loggedInUser = UserModel.fromMap(value.data());
      // setState(() {});
    });
    if(loggedInUser.name == null){
      name = user?.displayName;
      email = user?.email;
      photo = user?.photoURL;
    }
    else{
      name = loggedInUser.name!;
      email = loggedInUser.email;
    }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Logged In'),
          centerTitle: true,
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              onPressed: () {
                final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
                Fluttertoast.showToast(msg: "Logged Out successfully.");
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
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(photo),
              ),
              const SizedBox(height: 8),
              Text(
                'Name: $name',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                'Email: $email',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
        ),
      );
  }
    }
