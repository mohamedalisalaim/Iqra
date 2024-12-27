import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:iqra/models/reciter.dart';
import 'package:iqra/models/surah.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class QuranAudioService {
  static const String BASE_URL =
      "https://cdn.islamic.network/quran/audio-surah";

  Future<bool> checkPermission() async {
    final per = await Permission.storage.request();

    return per.isGranted;
  }

  Future<String> downloadSurhas(Reciter r, Surah s, int number) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileFolder =
          Directory('${dir.path}/${r.identifier}/${number}_${r.bitrate}');

      if (!await fileFolder.exists()) {
        await fileFolder.create(recursive: true);
      }

      for (int i = 1; i < s.array.length; i++) {
        String ayahUrl = "$BASE_URL/${r.bitrate}/${r.identifier}/${i + 1}.mp3";
        final ayahPath =
            "${fileFolder.path}/${r.bitrate}/${r.identifier}/${i + 1}.mp3";

        final res = await http.get(Uri.parse(ayahUrl));

        if (res.statusCode == 200) {
          final file = File(ayahPath);
          await file.writeAsBytes(res.bodyBytes);
        } else {
          print("soory");
        }
      }
      return fileFolder.path;
    } catch (e) {
      print(e);
      return "";
    }
  }
}
