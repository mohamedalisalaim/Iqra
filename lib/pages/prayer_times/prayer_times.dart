import 'package:flutter/material.dart';
import 'package:iqra/services/prayer_times_service.dart';
import 'package:iqra/utils/my_drawer.dart';

import '../../models/prayer_times/prayer.dart';

class PrayerTimesPage extends StatefulWidget {
  PrayerTimesPage({Key? key}) : super(key: key);

  @override
  _PrayerTimesPageState createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  final prayerService = PrayerTimeService();
  Prayer? _prayer_times;

  getPrayerTimes() async {
    final pos = await prayerService.getPosition();

    try {
      final prayer_times =
          await prayerService.getPrayers(pos.latitude, pos.longitude);
      setState(() {
        _prayer_times = prayer_times;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getPrayerTimes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: MyDrawer(),
      body: Center(
        child: Text(_prayer_times!.Fajr.toString()),
      ),
    );
  }
}

//   SafeArea newMethod() {
//     return SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.all(25),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Text(_prayer_times?.Fajr.toString() ?? "hello"),
//             Text(_prayer_times?.Dhuhr.toString() ?? "hello"),
//             Text(_prayer_times?.Asr.toString() ?? "hello"),
//             Text(_prayer_times?.Maghrib.toString() ?? "hello"),
//             Text(_prayer_times?.Isha.toString() ?? "hello"),
//           ],
//         ),
//       ),
//     );
//   }
// }
