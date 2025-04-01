import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumdum_delivery_app/model/customer.dart';
import 'package:tumdum_delivery_app/model/customer_order.dart';
import 'package:tumdum_delivery_app/model/restaurant.dart';
import 'package:tumdum_delivery_app/model/restaurant_user.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';

import 'services/fb_db_services.dart';
import 'util/intialize_util.dart';

@pragma('vm:entry-point')
Future onMessage(RemoteMessage message) async {}

late SharedPreferences sp;
void main() async {
  await IntializeUtil.initialize();
  // FirebaseFunctions.instance.useFunctionsEmulator("localhost", 5001);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<RestaurantUser>>.value(
            value: FbDbService.restaurantUsers, initialData: const []),
        StreamProvider<List<Restaurant>>.value(
            value: FbDbService.restaurants, initialData: const []),
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
                      color: Color(0xff00008B),
                    )
                  : const CupertinoActivityIndicator(
                      radius: 25,
                      color: Color(0xff00008B),
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
                    ColorScheme.fromSeed(seedColor: const Color(0xff00008B)),
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
