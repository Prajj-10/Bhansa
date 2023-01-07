
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/Home/Home_Custom_Widget/big_text.dart';
import 'package:cook_book/Home/Home_Custom_Widget/small_text.dart';
import 'package:cook_book/app/loginpage/loginPage.dart';
import 'package:cook_book/authentication/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../Home/Home_Custom_Widget/info_widget.dart';
import '../Home/Home_Custom_Widget/info_widget_2.dart';
import '../Home/Home_Custom_Widget/recipe_listview_widget.dart';
import '../Home/food_body_page.dart';
import '../app/SearchUser/SearchPerson.dart';
import '../app/loginpage/login.dart';
import '../model/user_model.dart';

class LoggedInWidget2 extends StatefulWidget{
  const LoggedInWidget2({super.key});

  @override
  LoggedInWidgetState2 createState() => LoggedInWidgetState2();
}
class LoggedInWidgetState2 extends State<LoggedInWidget2> {

  var name;
  var email;
  var photo;

  final ref = FirebaseDatabase.instance.ref('users');
  final user = FirebaseAuth.instance.currentUser;
  final googleSignIn = GoogleSignIn();
  UserModel loggedInUser = UserModel();

  void getDetails() async{
    //final user = await FirebaseAuth.instance.currentUser;
    //UserModel loggedInUser = UserModel();
    //CookingStepsModel recipeList = new CookingStepsModel();
    var userDetails = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

    setState(() {
      name = userDetails.data()!['name'];
      email = userDetails.data()!['email'];
      photo = userDetails.data()!['profile picture'];
    });
  }


  @override
  void initState() {
    getDetails();
    super.initState();

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
                backgroundColor: Color(0xFF061624).withOpacity(1.0),

                //Old code
                // title: const Text('Logged In'),
                // centerTitle: true,


                title: Row(
                  children: [
                    SizedBox(width: 10,),
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(photo?? ""),
                    ),
                    SizedBox(width: 10,),

                    BigText(text: "Hi! ${name} ", size: 16,)

                  ],
                ),


                actions: [
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    onPressed: () {
                      logout(context);
                    },
                    child: const Text('Logout'),
                  ),

                ],
              ),

              //New Code
              body: Column(
                children: [
                  InfoWidget(),
                  Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            FoodBodyPage(),
                            InfoWidget2(),
                            SizedBox(height: 20,),
                            RecipeListViewWidget(),
                          ],
                        ),
                      )),

                ],

              ),


              // //The this the old code wirtten by Prajjwal
              // body: Container(
              //   alignment: Alignment.center,
              //   color: Colors.blueGrey.shade900,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       const Text(
              //         'Profile',
              //         style: TextStyle(fontSize: 24),
              //       ),
              //       const SizedBox(height: 32),
              //       CircleAvatar(
              //         radius: 40,
              //         backgroundImage: NetworkImage(photo?? ""),
              //       ),
              //       const SizedBox(height: 8),
              //       Text(
              //         name?? "Your name here.",
              //         style: const TextStyle(color: Colors.white, fontSize: 16),
              //       ),
              //       const SizedBox(height: 8),
              //       Text(
              //         email?? "Your email here.",
              //         style: const TextStyle(color: Colors.white, fontSize: 16),
              //       ),
              //
              //     ],
              //   ),
              // ),
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


