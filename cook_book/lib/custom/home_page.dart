import 'package:cook_book/app/loginpage/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../app/loginpage/loginPage.dart';
import '../authentication/logged_in.dart';
import 'NavigationBar/navigation_bar.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: false,
    body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(
            color: Colors.blue,
          ));
        }
        else if(snapshot.hasError){
          return const Center(child: Text('Something went wrong !'));
        }
        else if(snapshot.hasData){
          var user = FirebaseAuth.instance.currentUser;
          //return  const LoggedInWidget();

          //Testing redirecting to Navigation page
          //Testing successful
         return  const Navigation();
        }
        else{
          return const LoginPage();
        }
      },
    ),
  );

}