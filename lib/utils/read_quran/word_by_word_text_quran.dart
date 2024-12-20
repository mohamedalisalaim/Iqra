import 'package:flutter/material.dart';
import 'package:iqra/models/read_quran/surah.dart';
import 'package:iqra/utils/read_quran/ayah_tile.dart';

class WordByWordTextQuran extends StatelessWidget {
  final Surah s;
  WordByWordTextQuran({
    super.key,
    required this.s,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: s.array.length,
      itemBuilder: (context, index) {
        //bool isLastOne = s.array[index][-1];
        //print(isLastOne);
        return AyahTile(
          ar: s.array[index]["ar"],
          en: s.array[index]["en"],
        );
      },
    );
  }
}
