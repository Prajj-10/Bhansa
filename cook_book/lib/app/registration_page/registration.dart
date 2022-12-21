
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/app/loginpage/loginPage.dart';
import 'package:cook_book/app/registration_page/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/user_model.dart';


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

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

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
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();

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
            const SizedBox(height: 70,),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Welcome to Cook Book!!!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 70,),

            TextFormField(


              controller: nameController,
              onChanged: (value){
                nametxt = value;
              },
              validator: (value){
                RegExp regex = RegExp(r'^.{3,}$');
                if(value!.isEmpty){
                  return("Name cannot be empty.");
                }
                if(!regex.hasMatch(value)){
                  return "Enter a Valid Name of minimum 3 characters.";
                }
              },
              style: const TextStyle(fontSize: 25, color: Color(0xffAAAAAA)),
              textInputAction: TextInputAction.next,
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

            const SizedBox(height: 20,),

            TextFormField(

              controller: addressController,

              onChanged: (value){
                addresstxt = value;
              },
              textInputAction: TextInputAction.next,
              validator: (value){
                RegExp regex = RegExp(r'^.{3,}$');
                if(value!.isEmpty){
                  return("Address cannot be empty.");
                }
                if(!regex.hasMatch(value)){
                  return "Enter a Valid Address.";
                }
                return null;
              },
              style: const TextStyle(fontSize: 25, color: Color(0xffAAAAAA)),
              decoration: const InputDecoration(
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

            const SizedBox(height: 20,),

            TextFormField(

              controller: emailController,

              onChanged: (value){
                emailtxt = value;
              },
              validator: (value){
                RegExp regex = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");
                if(value!.isEmpty){
                  return("Please enter your email address.");
                }
                if(!regex.hasMatch(value)){
                  return "Please enter a valid email address";
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              style: const TextStyle(fontSize: 25, color: Color(0xffAAAAAA)),
              decoration: const InputDecoration(
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

            const SizedBox(height: 20,),

            TextFormField(
              controller: passController,
              onChanged: (value){
                passwordtxt = value;
              },
              validator: (value){
                RegExp regex = RegExp(r'^.{8,}$');
                if(value!.isEmpty){
                  return("Password is empty.");
                }
                if(!regex.hasMatch(value)){
                  return "Please enter password with 8 minimum characters.";
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              style: const TextStyle(fontSize: 25, color: Color(0xffAAAAAA)),
              decoration: const InputDecoration(
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

            const SizedBox(height: 20,),

            TextFormField(
              controller: confirmPassController,
              onChanged: (value){
                confirmPasswordtxt = value;
              },
              validator:(value){
                if(confirmPassController.text.length>8 && passController!= value){
                  return "Passwords don't match.";
                }
                else{
                  return null;
                }
              },
              style: const TextStyle(fontSize: 25, color: Color(0xffAAAAAA)),
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
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

            const SizedBox(height: 20,),

            ElevatedButton(
              onPressed: (){
                signUp(emailController.text, passController.text);
                //print("Hello World");
                // insertData(nameController.text, addressController.text, emailController.text, passController.text, confirmPassController.text);
                //registerUser(context);
                //createUserWithEmailAndPassword();
                print("Hello World");
                clearcontrollers();
              },

              child: const Text("Sign Up"),
            ),

            const SizedBox(height: 20,),

            ElevatedButton(
              onPressed: (){
                //Navigator.push(context, MaterialPageRoute(builder: (context) => PostRecipe()));

              },
              child: const Text("Post"),
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

  void signUp(String email, String password) async{
    await _auth.createUserWithEmailAndPassword(email: email,
        password:password).then((value)=> {
      postDetailsToFireStore()
    }).catchError((e){
      Fluttertoast.showToast(msg: e!.message);
    /*if(_formKey.currentState!.validate()){
        });*/
    });
  }

  postDetailsToFireStore() async{
    // call FireStore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // call user model
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    // writing all values
    userModel.uid = user!.uid;
    userModel.name = nametxt;
    userModel.email = user.email;
    userModel.address = addresstxt;
    userModel.password = passwordtxt;

    await firebaseFirestore
    .collection("users")
    .doc(user.uid)
    .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");
    /*Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(
        builder: (context)=>const LoginPage()),
            (route) => false);*/


  }

  /*
  register users in old way
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
        .catchError((error){
          Fluttertoast.showToast(msg: error!.message);
    });
  }*/




/*void registerUser(context){
    final String email = emailController.text.trim();
    final String passowrd = passController.text.trim();

    context.read<AuthService>().signUp(email, passowrd);
  }*/


}