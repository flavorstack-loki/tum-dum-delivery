import 'package:flutter/material.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';
import 'package:tumdum_delivery_app/services/fb_db_services.dart';
import 'package:tumdum_delivery_app/services/location_services.dart';

import '../gen/assets.gen.dart';
import '../services/fb_auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_) async {
      LocationServices.locationPermission();

      try {
        final fuser = await FbAuthService.fUser.first;
        final user = await FbDbServices.getRestaurantByUid(fuser?.email);

        if (context.mounted) {
          if (fuser == null || user == null) {
            Navigator.of(context)
                .pushReplacementNamed(RouteGenerator.signInPage);
          } else {
            Navigator.of(context).pushReplacementNamed(
                RouteGenerator.restaurantLocationUpdatePage,
                arguments: user);
          }
        }
      } catch (e) {
        print(e.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff78192D),
        body: Center(
            child: Image.asset(
          Assets.images.splash.logo.path,
          fit: BoxFit.cover,
        )));
  }
}
