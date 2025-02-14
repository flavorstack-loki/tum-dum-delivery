import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtil {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future setupLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: DarwinInitializationSettings());

    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // ID
      'High Importance Notifications', // Name (same as strings.xml)
      description: 'Channel for important notifications', // Description
      importance: Importance.high,
      sound: RawResourceAndroidNotificationSound(
          'notification_sound'), // Custom sound
      playSound: true,
    );

    final AndroidFlutterLocalNotificationsPlugin? androidPlatformChannel =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlatformChannel != null) {
      await androidPlatformChannel.createNotificationChannel(channel);
    }
  }

  static Future<void> showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: "Channel for important notifications",
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound(
          'notification_sound'), // Predefined custom sound
      playSound: true,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await _flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title ?? 'New Order',
      message.notification?.body ?? 'Please view the app for details',
      platformChannelSpecifics,
    );

    // playCustomSound(); // Play loud sound manually
  }
}
