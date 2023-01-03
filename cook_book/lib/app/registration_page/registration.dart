
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cook_book/app/loginpage/login.dart';
import 'package:cook_book/app/loginpage/loginPage.dart';
import 'package:cook_book/app/registration_page/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
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

  final FirebaseFirestore firestore = FirebaseFirestore.instance;



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
  var userNameController = TextEditingController();
  // CollectionReference userRegistration = FirebaseFirestore.instance.collection('User Registration');


  // final dbRef = FirebaseDatabase.instance.reference();

  late bool passwordVisible;

  @override
  void initState() {
    // super.initState();
    passwordVisible = false;
  }

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

    // Username Field
    final userNameField = TextFormField(

        autofocus: false,
        controller: userNameController,
        // keyboardType: TextInputType.,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a username';
          }
          return null;
        },
        /*onChanged:(value){
          checkUsernameExists(value);
        },*/
        onSaved: (value) {
          nameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.abc_outlined),
          prefixText: "@",
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Username",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
    );
        // Use the CheckUsernameExistsWidget as the child of the TextFormField


    // Password Field

    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: !passwordVisible,
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

    // Confirm Password Field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordController,
        obscureText: !passwordVisible,
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
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //Signup Button

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.grey,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width/1.5,
          onPressed: () async{

              signUp(emailController.text, passwordController.text);
          },
          child: Text(
            "Sign Up ",
            textAlign: TextAlign.center,
              style: GoogleFonts.roboto(textStyle: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,)
          )),
    ));


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
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
                    const SizedBox(height: 70,),
                    Text("Create a new Account",
                        style: GoogleFonts.sacramento(
                            textStyle: const TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 55.0, color: Colors.white))
                    ),
                    const SizedBox(height: 20,),
                    nameField,
                    const SizedBox(height: 20,),
                    userNameField,
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
    );
  }
  void signUp(String email, String password) async {
    if (formKey.currentState!.validate()) {
      bool usernameTaken = await isUsernameTaken("@${userNameController.text}") as bool;
      if(usernameTaken){
        Fluttertoast.showToast(msg: "This username is taken.");
      }
      else{
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
    userModel.username = "@${userNameController.text}";
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

   isUsernameTaken(String username) async {
    // Query the Firestore database for a document with the desired username
    final QuerySnapshot snapshot = await firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    // If the snapshot is not empty, it means the username is already taken
    return snapshot.docs.isNotEmpty;
  }

  doesUsernameExist(String username) async {
    // Perform the query
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    // If the query returns a non-empty list of documents, it means that the username exists
    return querySnapshot.docs.isNotEmpty;
  }

  checkUsernameExists(String value) {
    return doesUsernameExist(value).then((exists) {
      if (exists) {
        return 'This username is already taken';
      }
      return "";
    });
  }



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
/*

class CheckUsernameExistsWidget extends StatefulWidget {
  final String value;
  final ValueChanged<String> onErrorMessageChanged;


  const CheckUsernameExistsWidget({required Key key, required this.value, required this.onErrorMessageChanged}) : super(key: key);

  @override
  _CheckUsernameExistsWidgetState createState() => _CheckUsernameExistsWidgetState();
}

class _CheckUsernameExistsWidgetState extends State<CheckUsernameExistsWidget> {
  late Future<String> _errorMessageFuture;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _errorMessageFuture = checkUsernameExists(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _errorMessageFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          widget.onErrorMessageChanged(snapshot.data!);
        } else {
          widget.onErrorMessageChanged("");
        }
        return Container();
      },
    );
  }

  Future<bool> doesUsernameExist(String username) async {
    // Perform the query
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    // If the query returns a non-empty list of documents, it means that the username exists
    return querySnapshot.docs.isNotEmpty;
  }

  Future<String> checkUsernameExists(String value) {
    return doesUsernameExist(value).then((exists) {
      if (exists) {
        return 'This username is already taken';
      }
      return "";
    });
  }
}*/
