import 'package:flutter/material.dart';

import 'editProfile.dart';

class BtnEditProfile extends StatelessWidget {
  const BtnEditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProfile()));
        },

        style: OutlinedButton.styleFrom(
          //backgroundColor: Colors.white,
          side: BorderSide(color: Colors.white),
          foregroundColor: Colors.orange,
          fixedSize: Size(100, 30),
        ),


          child: Text("Edit Profile"),

    );
  }
}
