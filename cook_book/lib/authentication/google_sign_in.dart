import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/user_model.dart';


class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final usersRef = FirebaseFirestore.instance.collection('users');

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
      }
        catch (e) {
          print(e.toString());
        }

    notifyListeners();
    createUserInFirestore();
    //const LoggedInWidget();
    // createUserInFirestore();
    // Fluttertoast.showToast(msg: "Logged In successfully.");
  }

  Future logout() async {
    await googleSignIn.currentUser?.clearAuthCache();
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();

  }
  createUserInFirestore() async{
    // check if user exists in the users collection.
    final GoogleSignInAccount? user = googleSignIn.currentUser;
    final currentUser = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot doc = await usersRef.doc(currentUser?.uid).get();

    if(!doc.exists){
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      // call user model
      UserModel userModel = UserModel();

      // writing all values
      userModel.uid = currentUser?.uid;
      userModel.name = user?.displayName;
      userModel.email = user?.email;
      userModel.profilePicture = user?.photoUrl;

      await firebaseFirestore
          .collection("users")
          .doc(currentUser?.uid)
          .set(userModel.toMap(), SetOptions(merge: true));
    }
  }

}
