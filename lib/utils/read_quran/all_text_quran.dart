import 'package:flutter/material.dart';

import '../../models/read_quran/surah.dart';

class AllTextQuran extends StatelessWidget {
  final Surah s;
  const AllTextQuran({
    super.key,
    required this.s,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: s.array.length,
      itemBuilder: (context, index) {
        return Text(s.array[index]["ar"]);
      },
    );
  }
}
