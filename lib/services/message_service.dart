import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widget/messenger.dart';

class MessageService {
  static void showErrorMessage(String message) {
    FToast().showToast(
      child: Messenger.messengerSnackBar(
          message, const Color(0xffbb2d13), Icons.info_outline),
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void showSuccessMessage(String message) {
    FToast().showToast(
      child: Messenger.messengerSnackBar(
          message, const Color(0xff0f8849), Icons.done),
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void showWarningMessage(String message) {
    FToast().showToast(
      child: Messenger.messengerSnackBar(
          message, const Color(0xffe8c259), FontAwesomeIcons.circleQuestion),
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void showInfoMessage(String message) {
    FToast().showToast(
      child: Messenger.messengerSnackBar(
          message, const Color(0xfffc9318), Icons.close),
      gravity: ToastGravity.BOTTOM,
    );
  }
}
