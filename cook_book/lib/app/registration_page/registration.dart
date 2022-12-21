import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/app/registration_page/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);


  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();

}

class _RegistrationPageState extends State<RegistrationPage> {

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        // errorMessage = e.message;
      });
    }
  }
  clearcontrollers(){
    nameController.clear();
    addressController.clear();
    emailController.clear();
    passController.clear();
    confirmPassController.clear();
  }
  var nameController = new TextEditingController();
  var addressController = new TextEditingController();
  var emailController = new TextEditingController();
  var passController = new TextEditingController();
  var confirmPassController = new TextEditingController();

  CollectionReference userRegistration = FirebaseFirestore.instance.collection('User Registration');
  String? nametxt, addresstxt, emailtxt, passwordtxt, confirmPasswordtxt;


  final dbRef = FirebaseDatabase.instance.reference();

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF061624).withOpacity(1.0),
      appBar: AppBar(
        title: const Text("Registration Page"),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(

          children:   [
            SizedBox(height: 70,),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Welcome to Cook Book!!!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 70,),

            TextField(

              controller: nameController,
              onChanged: (value){
                nametxt = value;
              },

              style: const TextStyle(fontSize: 25, color: Color(0xffAAAAAA)),
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: Color(0xffAAAAAA),
                  size: 40.0,
                ),
                hintText: "Name",
                hintStyle: TextStyle(fontSize: 25, color: Color(0xffAAAAAA)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F0EF)), //<-- SEE HERE
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F0EF)),
                ),
              ),
            ),

            SizedBox(height: 20,),

            TextField(

              controller: addressController,

              onChanged: (value){
                addresstxt = value;
              },

              style: TextStyle(fontSize: 25, color: Color(0xffAAAAAA)),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Color(0xffAAAAAA),
                  size: 40.0,
                ),
                hintText: "Address",
                hintStyle: TextStyle(fontSize: 25, color: Color(0xffAAAAAA)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F0EF)), //<-- SEE HERE
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEAEAEA)),
                ),
              ),
            ),

            SizedBox(height: 20,),

            TextField(

              controller: emailController,

              onChanged: (value){
                emailtxt = value;
              },
              style: TextStyle(fontSize: 25, color: Color(0xffAAAAAA)),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Color(0xffAAAAAA),
                  size: 40.0,
                ),
                hintText: "Email",
                hintStyle: TextStyle(fontSize: 25, color: Color(0xffAAAAAA)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F0EF)), //<-- SEE HERE
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEAEAEA)),
                ),
              ),
            ),

            SizedBox(height: 20,),

            TextField(

              controller: passController,
              onChanged: (value){
                passwordtxt = value;
              },
              style: TextStyle(fontSize: 25, color: Color(0xffAAAAAA)),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: Color(0xffAAAAAA),
                  size: 40.0,
                ),
                suffixIcon: Icon(
                  Icons.remove_red_eye,
                  color: Color(0xffAAAAAA),
                  size: 40.0,
                ),
                hintText: "Password",
                hintStyle: TextStyle(fontSize: 25, color: Color(0xffAAAAAA)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F0EF)), //<-- SEE HERE
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEAEAEA)),
                ),
              ),
            ),

            SizedBox(height: 20,),

            TextField(
              controller: confirmPassController,
              onChanged: (value){
                confirmPasswordtxt = value;
              },
              style: TextStyle(fontSize: 25, color: Color(0xffAAAAAA)),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: Color(0xffAAAAAA),
                  size: 40.0,
                ),
                suffixIcon: Icon(
                  Icons.remove_red_eye,
                  color: Color(0xffAAAAAA),
                  size: 40.0,
                ),
                hintText: "Confirm Password",
                hintStyle: TextStyle(fontSize: 25, color: Color(0xffAAAAAA)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffF3F0EF)), //<-- SEE HERE
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffEAEAEA)),
                ),
              ),
            ),

            SizedBox(height: 20,),

            ElevatedButton(
              onPressed: (){
                registerUsers();
                //print("Hello World");
                // insertData(nameController.text, addressController.text, emailController.text, passController.text, confirmPassController.text);
                //registerUser(context);
                createUserWithEmailAndPassword();
                print("Hello World");
                clearcontrollers();
              },

              child: Text("Sign Up"),
            ),

            SizedBox(height: 20,),

            ElevatedButton(
              onPressed: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context) => PostRecipe()));

              },
              child: Text("Post"),
            ),
          ],

        ),

      ),
    );
  }

/*  void insertData(String name, String address, String email, String password, String confirmPass){
    try {
      dbRef.child("users").push().set({
        "name": name,
        "address": address,
        "email": email,
        "password": password,
        "confirmPass": confirmPass
      });
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }


  }*/
  Future<void> registerUsers() {
    // Call the user's CollectionReference to add a new user
    return userRegistration
        .add({
      'Name': nametxt,
      'Address': addresstxt,
      'Email Address': emailtxt, // 42
      'Password': passwordtxt,
      'Confirm Password':confirmPasswordtxt
    })
        .then((value) => print("Posted"))
        .catchError((error) => print("Failed to add Recipe: $error"));
  }


/*void registerUser(context){
    final String email = emailController.text.trim();
    final String passowrd = passController.text.trim();

    context.read<AuthService>().signUp(email, passowrd);
  }*/


}