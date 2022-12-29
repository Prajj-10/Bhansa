
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/app/loginpage/login.dart';
import 'package:cook_book/app/loginpage/loginPage.dart';
import 'package:cook_book/app/registration_page/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/user_model.dart';


/*class Sign_Up extends StatefulWidget {
  const Sign_Up({Key? key}) : super(key: key);


  @override
  State<Sign_Up> createState() => _Sign_UpState();
}

class _Sign_UpState extends State<Sign_Up> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationPage(),
    );
  }
}*/

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();

}

class _RegistrationPageState extends State<RegistrationPage> {

  // Form Key for validation
  final formKey = GlobalKey<FormState>();

  // Auth Instance

  final auth = FirebaseAuth.instance;

  // Strinng to display error message

  String? errorMessage;

  // Controllers

  var nameController = TextEditingController();
  //var addressController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  CollectionReference userRegistration = FirebaseFirestore.instance.collection('User Registration');
  String? nametxt,  emailtxt, passwordtxt, confirmPasswordtxt;


  // final dbRef = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {

    // Phone Size
    var size = MediaQuery.of(context).size;

    // Name Field

    final nameField = TextFormField(
        autofocus: false,
        controller: nameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("First Name cannot be Empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid name(Min. 3 Character)");
          }
          return null;
        },
        onSaved: (value) {
          nameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //Email field

    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // Password Field

    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // Confirm Password Field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordController.text !=
              passwordController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //Signup Button

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.white38,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(emailController.text, passwordController.text);
          },
          child: const Text(
            "SignUp",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          )),
    );

    return Center(
      child: SingleChildScrollView(
        child: Container(
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                // Colors.white
                const Color(0xFF061624).withOpacity(1.0),
                const Color(0xFF081017).withOpacity(0.95),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Form(
              key: formKey,
              child: Column(
                    children:   [
                      nameField,
                      const SizedBox(height: 20,),

                      emailField,
                      const SizedBox(height: 20,),

                      passwordField,
                      const SizedBox(height: 20,),

                     confirmPasswordField,
                      const SizedBox(height: 20,),
                     signUpButton
                    ],
                  ),
            ),
          ),
        ),
      ),
    );
  }


  void signUp(String email, String password) async {
    if (formKey.currentState!.validate()) {
      try {
        await auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFireStore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
  clearControllers(){
    nameController.clear();
    //addressController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  /*void signUp(String email, String password) async{
    await auth.createUserWithEmailAndPassword(email: email,
        password:password).then((value)=> {
      postDetailsToFireStore()
    }).catchError((e){
      Fluttertoast.showToast(msg: e!.message);
      *//*if(_formKey.currentState!.validate()){
        });*//*
    });
  }*/
  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        // errorMessage = e.message;
      });
    }
  }

  postDetailsToFireStore() async{
    // call FireStore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // call user model
    User? user = auth.currentUser;
    UserModel userModel = UserModel();

    // writing all values
    userModel.uid = user!.uid;
    userModel.name = nametxt;
    userModel.email = user.email;
    //userModel.address = addresstxt;
    userModel.password = passwordtxt;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(
        builder: (context)=>const LoginScreen()),
            (route) => false);

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
mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length >= 6;

  bool isNameValid(String name) => name.length >=6;

  bool isEmailValid(String email) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
}