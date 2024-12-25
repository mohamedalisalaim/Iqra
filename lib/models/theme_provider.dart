import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  static final ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      // background
      surface: Color.fromRGBO(16, 16, 18, 1),

      // green color for buttons
      primary: Color.fromRGBO(125, 226, 96, 1),

      // secondary for interactive objects
      secondary: Color.fromRGBO(133, 133, 134, 1),
    ),
  );

  static final ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      // background
      surface: Colors.white,

      // green color for buttons
      primary: const Color.fromRGBO(125, 226, 96, 1),

      // secondary for interactive objects
      secondary: Colors.grey[200]!,
    ),
  );

  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
    notifyListeners();
  }
}
