
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
  final user = FirebaseAuth.instance.currentUser;
  final ref = FirebaseDatabase.instance.ref('users');
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    Fluttertoast.showToast(msg: "Logged In successfully.");
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
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value){
        loggedInUser = UserModel.fromMap(value.data());
      // setState(() {});
    });
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
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
        Fluttertoast.showToast(msg: "Logged Out Successfully.");
  }
}


/*

------- Old Code ------------

class LoggedInWidget extends StatefulWidget{

  User user;

  LoggedInWidget(this.user, {super.key});

  @override
  State<StatefulWidget> createState() {
    return  LoggedInWidgetState();
  }

}*/



/*
class LoggedInWidgetState extends State<LoggedInWidget>{

  User user;
   LoggedInWidgetState(this.user);
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  // GoogleSignInAccount get user => _user!;

   logout() async {
     */
/*final provider = Provider.of<GoogleSignInProvider>(context, listen : false);
     provider.logout();*//*

     await FirebaseAuth.instance.signOut();
     await googleSignIn.signOut();
   }
   String imgurl="https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.shutterstock.com%2Fsearch%2Fuser-profile&psig=AOvVaw2sIZ08GQKLHqUHCUs3NZdP&ust=1670293707840000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCODjnoq34fsCFQAAAAAdAAAAABAE";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(user?.photoURL != null){
      imgurl= user!.photoURL!;
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged In'),
        centerTitle: true,
        actions: [
          TextButton(
            child: const Text('Logout',
            style: TextStyle(color: Colors.white,
                fontSize: 20),
            ),
            onPressed: () {
              logout();
            },
          ),
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
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(
            height: 32,
          ),
          user?.photoURL != null?CircleAvatar(

            radius: 40,
            backgroundImage: NetworkImage( imgurl
            ),
          ):Container(),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Name : ${user.displayName == null?"no name ":(user.displayName)}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(
            height: 8,
          ),
          Text('Email : ${user?.email!}',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    )
    ,
      //    body: StreamBuilder(
      //      stream: FirebaseAuth.instance.authStateChanges(),
      //      builder: (context, snapshot) {
      //        if(snapshot.hasError){
      //          return const Center(child: Text('Something went wrong !'));
      //        }
      //        else if(snapshot.connectionState == ConnectionState.waiting){
      //          return const Center(child: CircularProgressIndicator(
      //            color: Colors.blue,
      //          ),
      //          );
      //        }
      //        else if(snapshot.hasData && snapshot.data != null){
      //
      //        }
      //        else{
      //          return const LoginScreen();
      //        }
      //      },
      // ),
    );
  }

}*/
