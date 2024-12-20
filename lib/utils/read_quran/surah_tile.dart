import 'package:flutter/material.dart';
import 'package:iqra/models/read_quran/surah.dart';
import 'package:iqra/utils/arabic_numbers.dart';

class SurahTile extends StatelessWidget {
  final Surah s;
  final int i;
  void Function()? onPressed;
  SurahTile({
    super.key,
    required this.s,
    required this.i,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Expanded(
        child: MaterialButton(
          padding: EdgeInsets.all(25),
          onPressed: onPressed,
          child: Column(
            children: [
              // first row with index(number) - name_en - (verse) - type - name -index(arabic)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${i + 1} - ${s.name_en}"),
                  Text(
                    "${ConvertToArabicNumbers({i + 1}.toString())} - ${s.name}",
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
              // second row with the words, verses, letters
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("words: ${s.words}"),
                  Text("${s.type}(${s.verses.toString()})"),
                  Text("letters: ${s.letters}")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
