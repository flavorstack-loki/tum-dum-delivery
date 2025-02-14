import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumdum_delivery_app/util/notification_util.dart';

import '../firebase_options.dart';
import '../main.dart';

class IntializeUtil {
  static Future initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    final res = await Future.wait([
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
      SharedPreferences.getInstance(),
      NotificationUtil.setupLocalNotifications(),
    ]);

    FirebaseMessaging.onBackgroundMessage(onMessage);
    FirebaseMessaging.onMessage.listen((message) {
      NotificationUtil.showNotification(message);
    });
    sp = res[1] as SharedPreferences;
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
  }
}
