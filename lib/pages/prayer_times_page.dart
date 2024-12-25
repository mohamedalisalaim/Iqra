import 'package:flutter/material.dart';
import 'package:iqra/models/prayer.dart';
import 'package:iqra/services/prayer_times_service.dart';

class PrayerTimesPage extends StatefulWidget {
  PrayerTimesPage({Key? key}) : super(key: key);

  @override
  _PrayerTimesPageState createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  final _prayers = PrayerTimesService();
  Prayer? p;

  getPrayersTimes() async {
    final pos = await _prayers.getCurrentLocation();

    final _p = await _prayers.getPrayers(pos.latitude, pos.longitude);

    print(_p);
    print(p);

    setState(() {
      p = _p;
    });
  }

  @override
  void initState() {
    getPrayersTimes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: (p != null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Fajr: ${p?.Fajr}"),
                  Text("Dhuhr: ${p?.Dhuhr}"),
                  Text("Asr: ${p?.Asr}"),
                  Text("Maghrib: ${p?.Maghrib}"),
                  Text("Isha: ${p?.Isha}"),
                ],
              ),
      ),
    );
  }
}
