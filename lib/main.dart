import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:tumdum_delivery_app/firebase_options.dart';
import 'package:tumdum_delivery_app/model/restaurant.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';

import 'services/fb_db_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFunctions.instance.useFunctionsEmulator("localhost", 5001);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Restaurant>>.value(
            value: FbDbService.restaurants, initialData: const []),
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
