import 'package:flutter/material.dart';

class QuranSettings extends ChangeNotifier {
  // reading types
  bool verseByVerse = false;
  bool showEnglishText = false;

  // fonts
  double fontSize = 18;
  double spaceBetweenWords = 1.5;
  bool quranFontBold = false;

  void changeReadingMode() {
    verseByVerse = !verseByVerse;
    notifyListeners();
  }

  void showEnglishQuran() {
    showEnglishText = !showEnglishText;
    notifyListeners();
  }

  void changeFontSize(double size) {
    fontSize = size;
    notifyListeners();
  }

  void changeFontHeight(double height) {
    spaceBetweenWords = height;
    notifyListeners();
  }

  void quranBoldFont() {
    quranFontBold = !quranFontBold;
    notifyListeners();
  }
}
