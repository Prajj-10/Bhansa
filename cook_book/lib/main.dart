import 'package:cook_book/authentication/google_sign_in.dart';
import 'package:cook_book/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'custom/NavigationBar/navigation_bar.dart'; //For Navbar
import 'custom/home_page.dart';
import 'app/loginpage/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => GoogleSignInProvider(),
    child : const MaterialApp(
      debugShowCheckedModeBanner: false,

      //home: HomePage(),
      
      home: SplashPage()

    ),
  );
}




