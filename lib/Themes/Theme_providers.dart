
import 'package:flutter/material.dart';
import 'package:zakat_app/Themes/dark_mood.dart';
import 'package:zakat_app/Themes/light_mood.dart';

class ThemeProviders with ChangeNotifier {
  ThemeData _themeData = lightMood;
  ThemeData get themeData => _themeData;
  bool get isDarkMood => _themeData == darkMood;

  set Themedata(ThemeData themeData)  {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (themeData == lightMood) {
      Themedata = darkMood;
    } else {
      Themedata = lightMood;
    }
  }
}
