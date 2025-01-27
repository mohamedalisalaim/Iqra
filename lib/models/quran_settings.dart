import 'package:flutter/material.dart';

class QuranSettings extends ChangeNotifier {
  // reading types
  bool verseByVerse = false;
  bool showEnglishText = false;

  // fonts
  double fontSize = 24;
  double spaceBetweenWords = 1.5;
  bool quranFontBold = false;

  double fontSizeEN = 14;

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

  void changeFontSizeEn(double size) {
    fontSizeEN = size;
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
