import 'package:flutter/material.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';

import '../gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then(
        (_) => Navigator.of(context).pushNamed(RouteGenerator.signInPage));
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
