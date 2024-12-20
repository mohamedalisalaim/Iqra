import 'package:flutter/material.dart';

class AyahTile extends StatelessWidget {
  final String ar;
  final String en;

  const AyahTile({
    super.key,
    required this.ar,
    required this.en,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25),
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.blueAccent[200],
      ),
      child: Column(
        children: [
          // arabic text
          Text(
            ar,
            textDirection: TextDirection.rtl,
          ),

          Padding(
            padding: const EdgeInsets.all(25),
            child: Divider(),
          ),

          // english text
          Text(
            en,
          )
        ],
      ),
    );
  }
}
