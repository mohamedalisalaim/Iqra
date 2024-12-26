import 'package:flutter/material.dart';
import 'package:iqra/models/prayer.dart';
import 'package:iqra/services/prayer_times_service.dart';

class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({super.key});

  @override
  _PrayerTimesPageState createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  final _prayers = PrayerTimesService();
  Prayer? p;

  getPrayersTimes() async {
    try {
      final pos = await _prayers.getCurrentLocation();

      final _p = await _prayers.getPrayers(pos.latitude, pos.longitude);

      setState(() {
        p = _p;
      });
    } catch (e) {
      return Exception("help me pleases");
    }
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
        child: p == null
            ? CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      "Fajr: ${p?.Fajr ?? "Not available"}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  //
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      "Dhuhr: ${p?.Dhuhr ?? "Not available"}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  //
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      "Asr: ${p?.Asr ?? "Not available"}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  //
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      "Maghrib: ${p?.Maghrib ?? "Not available"}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  //
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      "Isha: ${p?.Isha ?? "Not available"}",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
