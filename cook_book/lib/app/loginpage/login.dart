import 'package:cook_book/app/registration_page/registration.dart';
import 'package:cook_book/authentication/google_sign_in.dart';
import 'package:cook_book/authentication/logged_in2.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../custom/NavigationBar/navigation_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with InputValidationMixin {
  // Form Key
  final formKey = GlobalKey<FormState>();

  // Controllers

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Firebase Auth
  FirebaseAuth auth = FirebaseAuth.instance;
  String? errorMessage;
  late bool passwordVisible;

  @override
  void initState() {
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {

    // Phone Size
    var size = MediaQuery.of(context).size;

    // Email Field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (email) {
          if (isEmailValid(email!)) {
            return null;
          } else {
            return 'Enter a valid email address';
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

    //Password Field

    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: !passwordVisible,
        validator: (password) {
          if (isPasswordValid(password!)) {
            return null;
          } else {
            return 'Enter a valid password';
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          suffixIcon: IconButton(onPressed:(){
            setState(() {
              passwordVisible = !passwordVisible;
            });
          }, icon: Icon(
            passwordVisible
            ?Icons.visibility:Icons.visibility_off,
            color: Colors.white,
          )),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    // Login Button

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.grey,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width/2,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
              style: GoogleFonts.roboto(textStyle: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,),
          )),
    ));

    return Material(
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 150.0, left: 20.0, right: 20.0),

            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisSize: MainAxisSize.max,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cook Book',
                      style: GoogleFonts.sacramento(
                          textStyle: const TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 85.0, color: Colors.white))
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
                        child: Text("Relive your favourite foods.",
                          style: GoogleFonts.sacramento(
                            textStyle: const TextStyle(color: Colors.white,
                                fontSize: 35.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  emailField,
                  const SizedBox(
                    height: 20.0,
                  ),
                  passwordField,
                  const SizedBox(
                    height:20.0,
                  ),
                  loginButton,
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text("or connect using",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sacramento(textStyle: const TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: size.width/1.3,
                    child : FloatingActionButton.extended(
                      label: Text('Sign-In With Google',
                        style: GoogleFonts.roboto(textStyle: const TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,),
                        ),
                      ), // <-- Text
                      backgroundColor: Colors.grey,
                      icon: const Icon( // <-- Icon
                        FontAwesomeIcons.google,
                        size: 24.0,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                        provider.googleLogin();
                        if(provider.googleLogin() == true){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoggedInWidget2()));
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account ? ",
                      style: GoogleFonts.roboto(textStyle: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey
                      )),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const RegistrationPage()
                              ));
                        },
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.roboto(textStyle: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                          ),
                      ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ),
        ),
      ),
    );
  }

  // Login Function
  void signIn(String email, String password) async {
    if (formKey.currentState!.validate()) {
      try {
        await auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
          Fluttertoast.showToast(msg: "Login Successful"),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Navigation())),
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
        // print(error.code);
      }
    }
  }
}
mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length >= 6;

  bool isEmailValid(String email) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
}