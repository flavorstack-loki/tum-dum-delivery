import 'package:flutter/material.dart';

class Messenger {
  static Widget messengerSnackBar(
      String message, Color color, IconData iconData) {
    return Container(
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(25)),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: Text(
            message,
          )),
          Icon(
            iconData,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
