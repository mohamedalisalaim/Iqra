// a +10 in and rewind -10 s and puase and play button
// chose recreate

import 'package:flutter/material.dart';
import 'package:iqra/models/reciter.dart';

class AudioPlayerControllers extends StatelessWidget {
  final List<Reciter> r;
  const AudioPlayerControllers({super.key, required this.r});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        // chose reciter
        DropdownButton<String>(
          value: r[0].name,
          items: r.map((Reciter reciter) {
            return DropdownMenuItem<String>(
              value: reciter.name,
              child: Text(reciter.name),
            );
          }).toList(),
          onChanged: (value) {},
        ),

        // plays buttons here
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.replay_10_rounded),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.play_arrow_rounded),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.forward_10_rounded),
              onPressed: () {},
            )
          ],
        )
      ],
    ));
  }
}
