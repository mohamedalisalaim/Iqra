import 'package:flutter/material.dart';
import 'package:iqra/models/surah.dart';
import 'package:iqra/utlis/arabic_numbers.dart';

class SurahTile extends StatelessWidget {
  final Surah s;
  final int i;
  final void Function()? onPressed;
  const SurahTile({
    super.key,
    required this.s,
    required this.i,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: MaterialButton(
        color: Theme.of(context).colorScheme.primary,
        //textColor: Theme.of(context).colorScheme.surface,
        onPressed: onPressed,
        padding: const EdgeInsets.all(25),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${i + 1} - ${s.name_translation}",
                    style: const TextStyle(
                      fontFamily: "Odin",
                    ),
                  ),
                  Text(
                    "${ArabicNumber((i + 1).toString())} - ${s.name}",
                    textDirection: TextDirection.rtl,
                    style: const TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "عدد ألاحرف: ${ArabicNumber(s.words.toString())}",
                    style: const TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${s.type} - (${ArabicNumber(s.verses.toString())})",
                    style: const TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "عدد الكلمات: ${ArabicNumber(s.letters.toString())}",
                    style: const TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
