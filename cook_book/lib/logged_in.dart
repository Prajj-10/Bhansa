import 'package:cook_book/login.dart';
import 'package:cook_book/program.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'google_sign_in.dart';
class LoggedInWidget extends StatefulWidget{
  User user;

  LoggedInWidget(this.user, {super.key});

  @override
  State<StatefulWidget> createState() {
    return  LoggedInWidgetState(user);
  }

}
class LoggedInWidgetState extends State<LoggedInWidget>{
  User user;
   LoggedInWidgetState(this.user);

   logout(){
     /*final provider = Provider.of<GoogleSignInProvider>(context, listen : false);
     provider.logout();*/

     FirebaseAuth.instance.signOut();

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

}