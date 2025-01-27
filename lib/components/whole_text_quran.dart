import 'package:flutter/material.dart';
import 'package:iqra/models/quran_settings.dart';
import 'package:iqra/models/surah.dart';
import 'package:provider/provider.dart';

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
      child: SelectableText(
        s.ar,
        textAlign: TextAlign.justify,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontSize: Provider.of<QuranSettings>(context, listen: false).fontSize,
          fontWeight:
              (Provider.of<QuranSettings>(context, listen: false).quranFontBold)
                  ? FontWeight.bold
                  : FontWeight.normal,
          fontFamily: "Uthman",
          height: Provider.of<QuranSettings>(context, listen: false)
              .spaceBetweenWords,
        ),
      ),
    );
  }
}
