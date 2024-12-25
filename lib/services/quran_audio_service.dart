import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class QuranAudioService {
  static const String BASE_URL =
      "https://cdn.islamic.network/quran/audio-surah";

  Future downloadAudioFile(
      String identifier, int number, String bitrate) async {
    var permission = await Permission.storage.request();

    if (permission.isDenied == true) {
      permission = await Permission.storage.request();
    }

    try {
      Directory dir = await getApplicationDocumentsDirectory();
      String filePath = '${dir.path}/$identifier/${number}_$bitrate.mp4';

      var r = await http.get(
        Uri.parse("$BASE_URL/$bitrate/$identifier/$number.mp3"),
      );

      if (r.statusCode == 200) {
        File file = File(filePath);
        await file.writeAsBytes(r.bodyBytes);
      } else {
        print("we Tryied our best to save the patinet we are sorry");
      }
    } catch (e) {
      print(e);
    }
  }
}
