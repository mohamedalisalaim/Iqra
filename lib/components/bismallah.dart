import 'package:flutter/material.dart';

class Basmalah extends StatelessWidget {
  final double fontSize;
  const Basmalah({super.key, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      "بسم الله الرحمن الرحيم",
      style: TextStyle(
        fontFamily: "Uthman",
        fontSize: fontSize,
      ),
    );
  }
}
