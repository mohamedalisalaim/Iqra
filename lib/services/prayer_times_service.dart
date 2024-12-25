import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:iqra/models/prayer.dart';

class PrayerTimesService {
  static const BASE_URL = 'https://api.aladhan.com/timings';

  Future<Prayer> getPrayers(double latitude, double longitude) async {
    DateTime now = DateTime.now();
    final date = DateFormat('yyyy-MM-dd').format(now);

    final r = await http.get(Uri.parse(
        "$BASE_URL/$date?latitude=${latitude}&longitude=${longitude}&method=1"));

    try {
      var json = jsonDecode(r.body);
      return Prayer(
        Fajr: json["data"]["timings"]["Fajr"],
        Sunrise: json["data"]["timings"]["Sunrise"],
        Dhuhr: json["data"]["timings"]["Dhuhr"],
        Asr: json["data"]["timings"]["Asr"],
        Sunset: json["data"]["timings"]["Sunset"],
        Maghrib: json["data"]["timings"]["Maghrib"],
        Isha: json["data"]["timings"]["Isha"],
        Imsak: json["data"]["timings"]["Imsak"],
        Midnight: json["data"]["timings"]["Midnight"],
      );
    } catch (e) {
      throw Exception("hey");
    }
  }

  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position pos = await Geolocator.getCurrentPosition();

    return pos;
  }
}
