import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumdum_delivery_app/firebase_options.dart';
import 'package:tumdum_delivery_app/model/customer.dart';
import 'package:tumdum_delivery_app/model/customer_order.dart';
import 'package:tumdum_delivery_app/model/restaurant.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';
import 'package:tumdum_delivery_app/util/notification_util.dart';

import 'services/fb_db_services.dart';

@pragma('vm:entry-point')
Future onMessage(RemoteMessage message) async {
  NotificationUtil.showNotification(message);
}

late SharedPreferences sp;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationUtil.setupLocalNotifications();
  FirebaseMessaging.onBackgroundMessage(onMessage);
  FirebaseMessaging.onMessage.listen((message) {
    print("Received Notification: ${message.notification?.title}");
    NotificationUtil.showNotification(message);
  });
  sp = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: true,
    provisional: false,
    sound: true,
  );
  // FirebaseFunctions.instance.useFunctionsEmulator("localhost", 5001);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Restaurant>>.value(
            value: FbDbService.restaurantUsers, initialData: const []),
        StreamProvider<List<CustomerOrder>>.value(
            value: FbDbService.customerOrders, initialData: const []),
        StreamProvider<List<Customer>>.value(
            value: FbDbService.customers, initialData: const []),
      ],
      child: GlobalLoaderOverlay(
          overlayColor: Colors.grey.withValues(alpha: 0.8),
          overlayWidgetBuilder: (_) {
            //ignored progress for the moment
            return Center(
              child: Platform.isAndroid
                  ? const CircularProgressIndicator(
                      color: Color(0xff78192D),
                    )
                  : const CupertinoActivityIndicator(
                      radius: 25,
                      color: Color(0xff78192D),
                    ),
            );
          },
          child: MaterialApp(
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            title: 'TumDum ',
            initialRoute: RouteGenerator.splashPage,
            onGenerateRoute: RouteGenerator.generateRoute,
            theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: const Color(0xff78192D)),
                useMaterial3: true,
                listTileTheme: ListTileThemeData(
                    titleTextStyle: GoogleFonts.plusJakartaSans(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
                    bodyMedium: GoogleFonts.plusJakartaSans(
                        fontSize: 16, fontWeight: FontWeight.w500))),
          )),
    );
  }
}
