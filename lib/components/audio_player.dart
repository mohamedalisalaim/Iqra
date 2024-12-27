// a +10 in and rewind -10 s and puase and play button
// chose recreate

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:iqra/models/reciter.dart';
import 'package:iqra/services/quran_audio_service.dart';
import 'package:path_provider/path_provider.dart';

class AudioPlayerControllers extends StatefulWidget {
  final List<Reciter> r;
  Reciter reciter;
  int i;

  AudioPlayerControllers({
    super.key,
    required this.r,
    required this.reciter,
    required this.i,
  });

  @override
  State<AudioPlayerControllers> createState() => _AudioPlayerControllersState();
}

class _AudioPlayerControllersState extends State<AudioPlayerControllers> {
  final quranService = QuranAudioService();

  late AudioPlayer audioPlayer;
  Duration duration = Duration.zero;
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
        duration = newPos;
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

  playSurahQuran() async {
    var file = await quranService.downloadAudioFile(
        widget.reciter.identifier, widget.i, widget.reciter.bitrate);

    print(file);
    print(File(file));
    print(await File(file).exists());
    print(File(file).existsSync());
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

        // plays buttons here
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.replay_10_rounded),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.play_arrow_rounded),
              onPressed: () => playSurahQuran(),
            ),
            IconButton(
              icon: const Icon(Icons.forward_10_rounded),
              onPressed: () {},
            )
          ],
        )
      ],
    );
  }
}
