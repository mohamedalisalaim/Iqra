import 'package:flutter/material.dart';
import 'package:iqra/pages/prayer_times/prayer_times.dart';
import 'package:iqra/pages/read_quran/select_surhas.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Icon(Icons.help)),
          ListTile(
            title: Text("Quran Page"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectSurhasPage(),
                  ));
            },
          ),
          ListTile(
            title: Text("Prayer Time Page"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrayerTimesPage(),
                  ));
            },
          )
        ],
      ),
    );
  }
}
