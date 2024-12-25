import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iqra/components/audio_player.dart';
import 'package:iqra/components/whole_text_quran.dart';
import 'package:iqra/components/word_by_word_quran.dart';
import 'package:iqra/models/quran_settings.dart';
import 'package:iqra/models/reciter.dart';
import 'package:iqra/models/surah.dart';
import 'package:iqra/utlis/arabic_numbers.dart';
import 'package:provider/provider.dart';

import 'quran_settings_page.dart';

class ReadQuranPage extends StatefulWidget {
  final Surah s;
  final int i;
  const ReadQuranPage({
    super.key,
    required this.s,
    required this.i,
  });

  @override
  _ReadQuranPageState createState() => _ReadQuranPageState();
}

class _ReadQuranPageState extends State<ReadQuranPage> {
  List<Reciter> reciters = [];

  Future getReciters() async {
    var jsonString = await rootBundle.loadString("lib/assets/reciters.json");
    var json = jsonDecode(jsonString);

    for (int i = 0; i < json.length; i++) {
      final reciter = Reciter(
        identifier: json[i]["identifier"],
        name: json[i]["name"],
        bitrate: json[i]["bitrate"],
      );
      reciters.add(reciter);
    }
    setState(() {});
  }

  void changeReadType() {}

  @override
  void initState() {
    getReciters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuranSettings>(
      builder: (context, value, child) => Scaffold(
        // the app Bar
        appBar: AppBar(
          title: Text(
            "${ArabicNumber((widget.i + 1).toString())}. ${widget.s.name}",
            textDirection: TextDirection.rtl,
          ),
          actions: [
            // change the reading type to another
            IconButton(
              onPressed: changeReadType,
              icon: const Icon(Icons.book_rounded),
            ),
          ],
        ),

        //the body
        body: Column(
          children: [
            // quran text
            (value.isWordByWord)
                ? Expanded(child: WordByWordQuran(s: widget.s, i: widget.i))
                : Expanded(child: WholeTextQuran(s: widget.s, i: widget.i)),

            // controllers here
            const SizedBox(height: 5),
            AudioPlayerControllers(r: reciters),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
