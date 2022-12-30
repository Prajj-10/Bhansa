
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

class _RegistrationPageState extends State<RegistrationPage> with InputValidationMixin{

  // Form Key for validation
  final formKey = GlobalKey<FormState>();

  // Auth Instance

  final auth = FirebaseAuth.instance;

  // String to display error message

  String? errorMessage;

  // Controllers
  var nameController = TextEditingController();
  //var addressController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  CollectionReference userRegistration = FirebaseFirestore.instance.collection('User Registration');


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
        validator: (name) {
          if (isNameValid(name!)) {
            return null;
          } else {
            return 'Enter a valid name containing at least 6 characters.';
          }
        },
        onSaved: (value) {
          nameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Full Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //Email field

    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (email) {
          if (isEmailValid(email!)) {
            return null;
          } else {
            return 'Enter a valid email address.';
          }
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
        validator: (password) {
          if (passwordStructure(password!)) {
            return null;
          } else {
            return 'Enter a valid password. \n'
                'Password must contain: \n'
                '1.) One upper case \n'
                '2.) One lower case \n'
                '3.) One numeric number \n'
                '4.) One special character \n'
                '5.) Minimum 8 characters \n';
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

    return Container(
      padding: const EdgeInsets.only(top: 300),
      child: Center(
        child: Center(
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
  postDetailsToFireStore() async{
    // call FireStore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // call user model
    User? user = auth.currentUser;
    UserModel userModel = UserModel();

    // writing all values
    userModel.uid = user!.uid;
    userModel.name = nameController.text;
    userModel.email = user.email;
    //userModel.address = password;
    userModel.password = passwordController.text;

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
  /*clearControllers(){
    nameController.clear();
    //addressController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }*/

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
 /* Future<void> createUserWithEmailAndPassword() async {
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
  }*/



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

  bool isNameValid(String name) => name.length >=6 && name.isNotEmpty;

  bool passwordStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool isEmailValid(String email) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
}