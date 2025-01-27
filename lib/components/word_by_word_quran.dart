import 'package:flutter/material.dart';
import 'package:iqra/models/surah.dart';
import 'package:provider/provider.dart';

import '../models/quran_settings.dart';

class WordByWordQuran extends StatefulWidget {
  final Surah s;
  final int i;
  const WordByWordQuran({
    super.key,
    required this.s,
    required this.i,
  });

  @override
  State<WordByWordQuran> createState() => _WordByWordQuranState();
}

class _WordByWordQuranState extends State<WordByWordQuran> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.s.array.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // arbic quran
              SelectableText(
                widget.s.array[index]["ar"],
                textAlign: TextAlign.justify,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: "Uthman",
                  fontSize: Provider.of<QuranSettings>(context, listen: false)
                      .fontSize,
                  fontWeight:
                      (Provider.of<QuranSettings>(context, listen: false)
                              .quranFontBold)
                          ? FontWeight.bold
                          : FontWeight.normal,
                  height: Provider.of<QuranSettings>(context, listen: false)
                      .spaceBetweenWords,
                ),
              ),

              if (Provider.of<QuranSettings>(context, listen: false)
                  .showEnglishText)
                SelectableText(
                  widget.s.array[index]["en"],
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontFamily: "Odin",
                    fontSize: Provider.of<QuranSettings>(context, listen: false)
                        .fontSizeEN,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
