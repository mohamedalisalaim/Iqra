import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: GNav(
          onTabChange: (value) => onTabChange!(value),
          tabBorderRadius: 24,
          tabs: const [
            GButton(
              icon: Icons.access_time,
              text: "Prayer Times",
            ),
            GButton(
              icon: Icons.book_sharp,
              text: "Quran",
            ),
            // GButton(
            //   icon: Icons.compass_calibration,
            //   text: "Compass",
            // ),
          ]),
    );
  }
}
