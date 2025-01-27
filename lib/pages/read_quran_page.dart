import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iqra/components/audio_player.dart';
import 'package:iqra/components/bismallah.dart';
import 'package:iqra/components/whole_text_quran.dart';
import 'package:iqra/components/word_by_word_quran.dart';
import 'package:iqra/models/quran_settings.dart';
import 'package:iqra/models/reciter.dart';
import 'package:iqra/models/surah.dart';
import 'package:iqra/utlis/arabic_numbers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

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
  bool _hasPermission = false;

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

  void _fetchPermission() {
    Permission.storage.status.then((value) {
      if (mounted) {
        setState(() {
          _hasPermission = (value == PermissionStatus.granted);
        });
      }
    });
  }

  void _requstPermission() {
    Permission.storage.request().then(
      (value) {
        _fetchPermission();
      },
    );
  }

  @override
  void initState() {
    _fetchPermission();

    getReciters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuranSettings>(
      builder: (context, value, child) => Scaffold(
        // the app Bar
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "${ArabicNumber((widget.i + 1).toString())}. ${widget.s.name}",
            textDirection: TextDirection.rtl,
            style: const TextStyle(
                fontFamily: "Cairo", fontWeight: FontWeight.bold),
          ),
        ),

        //the body
        body: Column(
          children: [
            // bismallah
            (widget.i != 0 && widget.i != 8)
                ? Basmalah(
                    fontSize: Provider.of<QuranSettings>(context, listen: false)
                        .fontSize)
                : const SizedBox(),

            // quran text
            (value.verseByVerse)
                ? Flexible(child: WordByWordQuran(s: widget.s, i: widget.i), flex:3)
                : Flexible(child: WholeTextQuran(s: widget.s, i: widget.i),flex:100),


            // controllers here
            const SizedBox(height: 5),
            AudioPlayerControllers(
              r: reciters,
              reciter: reciters[0],
              i: widget.i,
              s: widget.s,
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
