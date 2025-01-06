import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

import '../services/message_service.dart';

class ReferenceUtil {
  static get locationUri => Platform.isIOS
      ? "https://maps.apple.com/?q="
      : "https://www.google.com/maps/search/?api=1&query=";

  static Future openUrl({required String uri}) async {
    if (await canLaunchUrl(Uri.parse(uri))) {
      try {
        await launchUrl(Uri.parse(uri));
      } catch (e) {
        MessageService.showErrorMessage("Couldn't open link.");
      }
    } else {
      MessageService.showErrorMessage("Couldn't open link.");
    }
  }
}
