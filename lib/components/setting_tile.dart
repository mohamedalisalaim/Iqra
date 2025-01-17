import 'package:flutter/cupertino.dart';

class SettingTile extends StatelessWidget {
  final String text;
  final void Function(bool)? onChanged;
  final bool value;
  const SettingTile({
    super.key,
    required this.text,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontFamily: "Odin",
          ),
        ),
        CupertinoSwitch(
          onChanged: onChanged,
          value: value,
        ),
      ],
    );
  }
}
