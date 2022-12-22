import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../app/loginpage/login.dart';
import '../main.dart';
import 'logged_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
    const LoggedInWidget();
    Fluttertoast.showToast(msg: "Logged In successfully.");
  }

  Future logout() async {
    // await googleSignIn.currentUser?.clearAuthCache();
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();


  }
}

/*

----------------Old Code--------------------------

class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoggedInWidget(FirebaseAuth.instance.currentUser!)));
    }
    catch (e) {
      print(e.toString());
    }


    notifyListeners();
  }
  Future logout() async{

    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

--------------------------------------------------

}*/
