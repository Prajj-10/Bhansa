import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

import 'app/loginpage/loginPage.dart';
import 'custom/NavigationBar/navigation_bar.dart';
import 'custom/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
        logo: Image.asset('assets/BhansaWhite.png' ),
        logoWidth: 130,
        // title: const Text(
        //   " ",
        //   style: TextStyle(
        //     fontSize: 18,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        showLoader: true,
        backgroundColor: const Color(0xFF061624).withOpacity(1.0),
        loaderColor: Colors.white,
        loadingText: const Text("Loading..."),
        navigator: const HomePage(),

        //Testing navigate to login page
        //navigator: const Navigation(),

        durationInSeconds: 5,
      );
  }
}