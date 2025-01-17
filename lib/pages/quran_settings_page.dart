import 'package:flutter/material.dart';
import 'package:iqra/components/setting_tile.dart';
import 'package:iqra/models/quran_settings.dart';
import 'package:iqra/models/theme_provider.dart';
import 'package:provider/provider.dart';

class QuranSettingsPage extends StatefulWidget {
  QuranSettingsPage({Key? key}) : super(key: key);

  @override
  _QuranSettingsPageState createState() => _QuranSettingsPageState();
}

class _QuranSettingsPageState extends State<QuranSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuranSettings>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "App Settings",
            style: TextStyle(
              fontFamily: "Odin",
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        //  some space to breath man, yeah like that

        body: ListView(
          padding: EdgeInsets.all(25),
          children: [
            // dark mode
            SettingTile(
              text: "Dark Mode",
              onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
              value:
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
            ),

            // verse by verse
            SettingTile(
              text: "Show Verse By Verse Mode",
              onChanged: (type) =>
                  Provider.of<QuranSettings>(context, listen: false)
                      .changeReadingMode(),
              value: Provider.of<QuranSettings>(context, listen: false)
                  .verseByVerse,
            ),

            // show english text
            SettingTile(
              text: "Show English Quran Text",
              onChanged: (type) =>
                  Provider.of<QuranSettings>(context, listen: false)
                      .showEnglishQuran(),
              value: Provider.of<QuranSettings>(context, listen: false)
                  .showEnglishText,
            ),

            // font size here
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Font Size",style:TextStyle(fontFamily:"Odin",fontWeight:FontWeight.bold)),
                Slider(
                  activeColor: Theme.of(context).colorScheme.primary,
                  inactiveColor: Colors.greenAccent[100],
                  divisions: 6,
                  min: 8,
                  max: 32,
                  label: Provider.of<QuranSettings>(context, listen: false)
                      .fontSize
                      .toString(),
                  value: Provider.of<QuranSettings>(context, listen: false)
                      .fontSize,
                  onChanged: (value) =>
                      Provider.of<QuranSettings>(context, listen: false)
                          .changeFontSize(value),
                ),
              ],
            ),

            // quran font bold
            SettingTile(
              text: "Quran Bold text",
              onChanged: (type) =>
                  Provider.of<QuranSettings>(context, listen: false)
                      .quranBoldFont(),
              value: Provider.of<QuranSettings>(context, listen: false)
                  .quranFontBold,
            ),

            // heigth between words
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Font Height (space between words)",style:TextStyle(fontFamily:"Odin",fontWeight:FontWeight.bold)),
                Slider(
                  activeColor: Theme.of(context).colorScheme.primary,
                  inactiveColor: Colors.greenAccent[100],
                  divisions: 4,
                  label: Provider.of<QuranSettings>(context, listen: false)
                      .spaceBetweenWords
                      .toString(),
                  min: 1,
                  max: 3,
                  value: Provider.of<QuranSettings>(context, listen: false)
                      .spaceBetweenWords,
                  onChanged: (value) =>
                      Provider.of<QuranSettings>(context, listen: false)
                          .changeFontHeight(value),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
