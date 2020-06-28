import 'package:flutter/material.dart';

enum ThemeEnum { LIGHT, DARK }

class ThemeProvider with ChangeNotifier {
  static final ThemeData lightTheme =
      ThemeData(primaryColor: Colors.white, brightness: Brightness.light);

  static final ThemeData darkTheme = ThemeData(
      primaryColor: Color(0xff010001),
      accentColor: Color(0xff00171f),
      brightness: Brightness.dark
      // visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  ThemeData activeTheme = darkTheme;

  ThemeData get currentTheme => activeTheme;

  void toggleTheme() {
    activeTheme = currentTheme == darkTheme ? lightTheme : darkTheme;
    notifyListeners();
  }
}
