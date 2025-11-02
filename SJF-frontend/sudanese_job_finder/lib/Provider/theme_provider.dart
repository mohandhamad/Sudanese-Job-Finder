import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class AppTheme {
  static final darkTheme = ThemeData(
    fontFamily: 'roboto',
    // brightness: Brightness.dark,
    scaffoldBackgroundColor:  const Color(0xFF121212),
    colorScheme: const ColorScheme.dark(),
    focusColor: Colors.white,
    cardColor: const Color(0xFF1E1E1E),
    primaryColor: const Color(0xFF272727),
    secondaryHeaderColor: const Color(0xFF272727),
  );

  static final lightTheme = ThemeData(
    fontFamily: 'roboto',
    // brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(),
    focusColor: Colors.black,
    cardColor: Colors.grey.shade100,
    primaryColor: Colors.grey.shade300,
    secondaryHeaderColor: Colors.grey,
  );
}