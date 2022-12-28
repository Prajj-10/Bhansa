import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/app/EditProfile/editProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
class UpdateElevatedButton extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  UpdateElevatedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF215C76),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
              foregroundColor: Colors.white,
              textStyle: TextStyle(
                color: Colors.green,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),

          ),
          onPressed: (){
            final docUser = FirebaseFirestore.instance
                .collection("users").doc(user?.uid);
            // docUser.update(EditProfile())
          },
          child: Center(
            child: Text("Save Changes"),
          )
      ),
    );
  }
}
