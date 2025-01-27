import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:iqra/models/reciter.dart';
import 'package:iqra/models/surah.dart';
import 'package:iqra/services/quran_audio_service.dart';
import 'package:path_provider/path_provider.dart';

class AudioPlayerControllers extends StatefulWidget {
  final List<Reciter> r;
  Reciter reciter;
  int i;
  final Surah s;

  AudioPlayerControllers({
    super.key,
    required this.r,
    required this.reciter,
    required this.i,
    required this.s,
  });

  @override
  State<AudioPlayerControllers> createState() => _AudioPlayerControllersState();
}

class _AudioPlayerControllersState extends State<AudioPlayerControllers> {
  final quranService = QuranAudioService();

  late AudioPlayer audioPlayer;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPos) {
      setState(() {
        position = newPos;
      });
    });

    audioPlayer.onPlayerComplete.listen((events) {
      setState(() {
        isPlaying = true;
        duration = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  String formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    return "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
  }

  playSurahQuran() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String filePath = "${appDocDir.path}/${widget.reciter.name}/${widget.i}.mp3";

    if (isPlaying) {
      audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      if (await quranService.checkFileExist(filePath)) {
        audioPlayer.play(DeviceFileSource(filePath));
        setState(() {
          isPlaying = true;
        });
      } else {
        await quranService.downloadSurah(widget.reciter, widget.i);
        audioPlayer.play(DeviceFileSource(filePath));
        setState(() {
          isPlaying = true;
        });
      }
    }
  }

  void handleSeek(double value) {
    audioPlayer.seek(Duration(seconds: value.toInt()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // chose reciter
        DropdownButton<String>(
          alignment: Alignment.center,
          value: widget.reciter.name,
          items: widget.r.map((Reciter reciter) {
            return DropdownMenuItem<String>(
              value: reciter.name,
              child: Text(reciter.name),
            );
          }).toList(),
          onChanged: (value) => setState(() {
            widget.reciter = widget.r.firstWhere((r) => r.name == value);
          }),
        ),

        // the slider
        Padding(child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatDuration(position)),
            Slider(
              min: 0.0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: handleSeek,
            ),
            Text(formatDuration(duration)),
          ],
        ),padding: EdgeInsets.all(12)),

        // plays buttons here
        Padding(child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.replay_10_rounded),
              onPressed: () {},
            ),
            IconButton(
              icon: (isPlaying) ? Icon(Icons.play_arrow) : Icon(Icons.pause),
              onPressed: playSurahQuran,
            ),
            IconButton(
              icon: const Icon(Icons.forward_10_rounded),
              onPressed: () {},
            ),
          ],
        ),padding:EdgeInsets.all(12)),
      ],
    );
  }
}
