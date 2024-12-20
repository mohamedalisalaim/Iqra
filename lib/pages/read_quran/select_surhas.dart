import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iqra/models/read_quran/surah.dart';
import 'package:iqra/pages/read_quran/search_quran.dart';
import 'package:iqra/pages/read_quran/surah_quran.dart';
import 'package:iqra/utils/read_quran/surah_tile.dart';
import 'package:iqra/utils/my_drawer.dart';

class SelectSurhasPage extends StatefulWidget {
  SelectSurhasPage({super.key});

  @override
  State<SelectSurhasPage> createState() => _SelectSurhasPageState();
}

class _SelectSurhasPageState extends State<SelectSurhasPage> {
  List<Surah> surahs = [];

  Future getData() async {
    var jsonString = await rootBundle.loadString("lib/assets/data/Quran.json");
    var json = jsonDecode(jsonString);
    List<Surah> _surahs = [];
    for (int i = 0; i < 113; i++) {
      final s = Surah(
        name: json[i]["name"],
        name_en: json[i]["name_en"],
        name_translation: json[i]["name_translation"],
        words: json[i]["words"],
        letters: json[i]["letters"],
        type: json[i]["type"],
        type_en: json[i]["type_en"],
        ar: json[i]["ar"],
        en: json[i]["en"],
        verses: json[i]["verses"],
        array: json[i]["array"],
        path: List.generate(
          json[i]["array"].length,
          (index) => json[i]["array"][index]["path"],
        ),
        word_by_word_ar: List.generate(
          json[i]["array"].length,
          (index) => json[i]["array"][index]["ar"],
        ),
        word_by_word_en: List.generate(
          json[i]["array"].length,
          (index) => json[i]["array"][index]["en"],
        ),
      );
      _surahs.add(s);
    }
    setState(() {
      surahs = _surahs;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //nav bar

        drawer: MyDrawer(),
        // app bar
        appBar: AppBar(
          title: Text(
            "IQRA",
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchQuranPage(),
                ),
              ),
            ),
          ],
        ),

        // to seprate the code a bit

        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: surahs.length,
                itemBuilder: (context, index) {
                  return SurahTile(
                    s: surahs[index],
                    i: index,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SurahQuranPage(
                              i: index,
                              s: surahs[index],
                            ),
                          ));
                    },
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
