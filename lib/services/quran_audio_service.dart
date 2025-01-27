import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:iqra/models/reciter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class QuranAudioService {
  Future<bool> checkPermission() async {
    final per = await Permission.storage.request();

    return per.isGranted;
  }

  Future<bool> checkFileExist(filePath) async {
    File file = File(filePath);
    return await file.exists();
  }

  Future<void> downloadSurah(Reciter r, int number) async {
    if (await Permission.storage.request().isGranted) {
      try {
        String linkToDownload =
            "https://cdn.islamic.network/quran/audio-surah/${r.bitrate}/${r.identifier}/$number";

        Directory appDocDir = await getApplicationDocumentsDirectory();
        String fileName = "${appDocDir.path}/${r.name}/$number";

	if (await checkFileExist(fileName)) {
          print("File already exists: $fileName");
          return;
        }

        final res = await http.get(Uri.parse(linkToDownload));

        if (res.statusCode == 200) {
          File file = File(fileName);
          file.writeAsBytes(res.bodyBytes);
          print("File is being Downloaded");
        } else {
          print("erorr");
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      print("erorr permission error");
    }
  }
}
