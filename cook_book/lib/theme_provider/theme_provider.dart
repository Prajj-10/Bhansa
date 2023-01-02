import 'package:flutter/material.dart';


class MyThemes{

  //For Dark Theme
  static final darkTheme = ThemeData(
    primarySwatch: Colors.cyan,
    primaryColor: Colors.black,
    primaryColorDark: const Color(0xFF061624).withOpacity(1.0),
    scaffoldBackgroundColor: const Color(0xFF061624).withOpacity(1.0),

    colorScheme: const ColorScheme.dark(),

  );

  //For Light Theme
  static final lightTheme = ThemeData(
    primarySwatch: Colors.cyan,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),

  );
}