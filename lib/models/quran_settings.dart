import 'package:flutter/material.dart';

class QuranSettings extends ChangeNotifier {
  // reading types
  bool isWordByWord = false;
  bool showEnglishText = false;
  // fonts
  String fontNameQuran = "Kfg";
  String fontName = "Cairo";
  int fontSize = 20;
  bool fontBold = false;

  void toggle(bool Function() getBool, void Function(bool) setBool) {
    setBool(
      !getBool(),
    );
    notifyListeners();
  }
}
