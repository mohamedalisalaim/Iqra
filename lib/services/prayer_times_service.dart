import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:iqra/models/prayer.dart';
import 'package:qibla_direction/qibla_direction.dart';

class PrayerTimesService {
  static const BASE_URL = 'https://api.aladhan.com/timings';

  Future<Prayer> getPrayers(double latitude, double longitude) async {
    DateTime now = DateTime.now();
    final date = DateFormat('yyyy-MM-dd').format(now);

    final r = await http.get(Uri.parse(
        "$BASE_URL/$date?latitude=$latitude&longitude=$longitude&method=3"));

    try {
      var json = jsonDecode(r.body);
      return Prayer(
        Fajr: formatDate(json["data"]["timings"]["Fajr"]),
        Sunrise: formatDate(json["data"]["timings"]["Sunrise"]),
        Dhuhr: formatDate(json["data"]["timings"]["Dhuhr"]),
        Asr: formatDate(json["data"]["timings"]["Asr"]),
        Sunset: formatDate(json["data"]["timings"]["Sunset"]),
        Maghrib: formatDate(json["data"]["timings"]["Maghrib"]),
        Isha: formatDate(json["data"]["timings"]["Isha"]),
        Imsak: formatDate(json["data"]["timings"]["Imsak"]),
        Midnight: formatDate(json["data"]["timings"]["Midnight"]),
      );
    } catch (e) {
      throw Exception("hey");
    }
  }

  formatDate(String time) {
    final timeFormat = DateFormat("HH:mm");
    final date = timeFormat.parse(time);
    return DateFormat("hh:mm a").format(date);
  }

  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position pos = await Geolocator.getCurrentPosition();

    return pos;
  }

  Future getCord() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position pos = await Geolocator.getCurrentPosition();

    return Coordinate(pos.latitude, pos.longitude);
  }
}
