import 'package:flutter/material.dart';
import 'package:iqra/models/surah.dart';

class WholeTextQuran extends StatelessWidget {
  final Surah s;
  final int i;
  const WholeTextQuran({
    super.key,
    required this.s,
    required this.i,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: SingleChildScrollView(
        child:
          Text(
            s.ar,
            textDirection: TextDirection.rtl,
          ),
        
      ),
    );
  }
}
