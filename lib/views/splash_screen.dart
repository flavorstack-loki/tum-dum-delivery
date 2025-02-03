import 'package:flutter/material.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';
import 'package:tumdum_delivery_app/services/location_services.dart';
import 'package:tumdum_delivery_app/util/color_util.dart';

import '../gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      LocationServices.locationPermission();
      Navigator.of(context).pushNamed(RouteGenerator.signInPage);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorUtil.primaryColor,
        body: Center(
            child: Image.asset(
          Assets.images.splash.logo.path,
          fit: BoxFit.cover,
        )));
  }
}
