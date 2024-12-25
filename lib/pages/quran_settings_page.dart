import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              // for isWordByWord swith
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("isWordByWord"),
                    CupertinoSwitch(
                      value: value.isWordByWord,
                      onChanged: (type) {
                        value.isWordByWord = type;
                        // setState(() {});
                      },
                    ),
                  ],
                ),
              ),

              // theme modes
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("dark mode"),
                    CupertinoSwitch(
                      value: Provider.of<ThemeProvider>(context, listen: false)
                          .isDarkMode,
                      onChanged: (type) {
                        print(type);
                        print(value.isWordByWord);

                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                       
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
