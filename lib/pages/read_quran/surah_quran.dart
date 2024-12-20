import 'package:flutter/material.dart';
import 'package:iqra/models/read_quran/surah.dart';
import 'package:iqra/utils/read_quran/word_by_word_text_quran.dart';

class SurahQuranPage extends StatefulWidget {
  final int i;
  final Surah s;
  SurahQuranPage({
    super.key,
    required this.i,
    required this.s,
  });

  @override
  _SurahQuranPageState createState() => _SurahQuranPageState();
}

class _SurahQuranPageState extends State<SurahQuranPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.i + 1} - ${widget.s.name}"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: WordByWordTextQuran(
        s: widget.s,
      ),
    );
  }
}
