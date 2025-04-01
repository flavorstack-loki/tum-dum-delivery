import 'package:flutter/material.dart';
import 'package:tumdum_delivery_app/main.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';
import 'package:tumdum_delivery_app/util/string_constants.dart';

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
      final email = sp.getString(StringConstants.restaurantIdKeyText);
      if (context.mounted) {
        Navigator.of(context).pushNamed(email != null
            ? RouteGenerator.homePage
            : RouteGenerator.signInPage);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Image.asset(
          Assets.images.splash.logo.path,
          fit: BoxFit.cover,
        )));
  }
}
