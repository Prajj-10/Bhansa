import 'package:cook_book/authentication/google_sign_in.dart';
import 'package:cook_book/program.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Login Function
  static Future<User?> loginUsingEmail(String email, String password, BuildContext context ) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    }on FirebaseAuthException catch (e){
      if(e.code == 'user-not-found'){
        print("No User Found for that email");
      }
    }
    return user;

  }


  @override
  Widget build(BuildContext context) {
    // TextField Controller
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    var size = MediaQuery.of(context).size;
    bool obscureText = true;
    return Material(
      child: Container(
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
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

            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisSize: MainAxisSize.max,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cook Book',
                      style: GoogleFonts.yesteryear(
                          textStyle: const TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 70.0, color: Colors.white))
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 15.0),
                        child: Text("Welcome !",
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(color: Colors.white,
                                fontSize: 30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Text("Sign In",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 25.0, color: Colors.white)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text("Sign Up",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 25.0, color: Colors.white38)
                          ),
                        ),
                      ),

                    ],
                  ),



                  const SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "User Email",
                      hintStyle: TextStyle(
                        color: Colors.white38,
                      ),
                      prefixIcon: Icon(Icons.mail_lock_outlined, color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.white),
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      hintText: "User Password",
                      hintStyle: const TextStyle(
                        color: Colors.white38,
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Colors.white),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        child: Icon(obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      ),
                    ),
                  const SizedBox(
                    height:20.0,
                  ),
                  SizedBox(
                    width: size.width/2.5,
                    child: RawMaterialButton(
                      fillColor: Colors.grey,
                      elevation: 4.0,
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      onPressed: () async{
                        User? user = await loginUsingEmail(_emailController.text,_passwordController.text,context);
                        print(user);
                        if (user !=null){
                          Program.user= user;
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>  const LoggedInWidget()));
                        }
                      },
                      child: Text("Login",
                        style: GoogleFonts.roboto(textStyle: const TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30.0,
                  ),
                  Text("Or Connect using",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(textStyle: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
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
                      },
                    ),
                  ),
                ],
              ),

          ),
        ),
      ),
    );

  }
}