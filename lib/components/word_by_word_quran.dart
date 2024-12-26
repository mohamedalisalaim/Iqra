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
          child: Column(
            children: [
              Text(
                widget.s.array[index]["ar"],
                style: TextStyle(
                    fontFamily: Provider.of<QuranSettings>(context).fontName),
              ),
            ],
          ),
        );
      },
    );
  }
}
