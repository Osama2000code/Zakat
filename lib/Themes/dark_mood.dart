import 'package:flutter/material.dart';

ThemeData darkMood = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color.fromARGB(255, 0, 0, 0), //backround
    primary: Color(0xff01969c), //for bouttons and iconback
    onBackground: Color.fromARGB(255, 29, 29, 29), //Card backround
    secondary: Color.fromARGB(255, 55, 55, 55), //tile back round
    inversePrimary: Color(0xffbababa),
    inverseSurface: Color.fromARGB(255, 255, 255, 255),
  ),
);
