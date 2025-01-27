import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iqra/components/surah_tile.dart';
import 'package:iqra/models/surah.dart';
import 'package:iqra/pages/quran_settings_page.dart';
import 'package:iqra/pages/read_quran_page.dart';

class SurhasPage extends StatefulWidget {
  const SurhasPage({super.key});

  @override
  _SurhasPageState createState() => _SurhasPageState();
}

class _SurhasPageState extends State<SurhasPage> {
  List<Surah> s = [];

  Future getSurhas() async {
    var jsonString = await rootBundle.loadString("lib/assets/quran.json");
    var json = jsonDecode(jsonString);
    List<Surah> tempList = [];

    for (int i = 0; i < 114; i++) {
      final _s = Surah(
        name: json[i]["name"],
        name_translation: json[i]["name_translation"],
        words: json[i]["words"],
        letters: json[i]["letters"],
        verses: json[i]["verses"],
        type: json[i]["type"],
        ar: json[i]["ar"],
        en: json[i]["en"],
        array: List.from(json[i]["array"]),
      );
      tempList.add(_s);
    }

    setState(() {
      s = tempList;
    });
  }

  @override
  void initState() {
    getSurhas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "IQRA",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuranSettingsPage(),
                          ),
                        ),
                        icon: const Icon(Icons.settings_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            (s.isNotEmpty)
                ? Flexible(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(25),
                      itemCount: s.length,
                      itemBuilder: (context, index) => SurahTile(
                        s: s[index],
                        i: index,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReadQuranPage(
                                s: s[index],
                                i: index,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
