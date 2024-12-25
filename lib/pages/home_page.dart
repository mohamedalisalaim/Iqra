import 'package:flutter/material.dart';
import 'package:iqra/components/my_bottom_nav_bar.dart';
import 'package:iqra/pages/prayer_times_page.dart';
import 'package:iqra/pages/surhas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  final List<Widget> _pages = [
    PrayerTimesPage(),
    SurhasPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: _pages[_pageIndex],
    );
  }
}
