import 'package:flutter/material.dart';

class InfoCardWidget extends StatelessWidget {
  const InfoCardWidget(
      {required this.text, required this.onPressed, super.key});
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: ListTile(
          onTap: onPressed,
          visualDensity: const VisualDensity(horizontal: -4),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          title: Text(
            text,
            style: const TextStyle(fontSize: 18),
          ),
          trailing: IconButton(
              padding: EdgeInsets.zero,
              visualDensity: const VisualDensity(horizontal: -4),
              onPressed: onPressed,
              icon: const Icon(
                Icons.keyboard_arrow_right,
                size: 30,
              )),
        ));
  }
}
