
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

import '../app/SearchUser/SearchPerson.dart';
import '../app/loginpage/login.dart';
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
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            ),);
          }
          else if(snapshot.hasError){
            const Center(
              child: Text("Error!! Please check your internet connection."),
            );
          }
          else if(snapshot.hasData){
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
                  ),

                  //Testing person search assuming
                  IconButton(onPressed: () => showSearch(context: context, delegate: SearchPerson()),
                      icon: Icon(Icons.search_rounded))
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
          else{
            return const Center(
              child: Text("Something went wrong. Please try again later."),
            );
          }
          return const SizedBox();
        }
      ),
    );
  }
  Future<void> logout(BuildContext context) async {
    await googleSignIn.currentUser?.clearAuthCache();
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
        Fluttertoast.showToast(msg: "Logged Out Successfully.");
  }
}


