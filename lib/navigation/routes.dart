import 'package:flutter/material.dart';
import 'package:tumdum_delivery_app/views/home_screen.dart';
import 'package:tumdum_delivery_app/views/login_screen.dart';
import 'package:tumdum_delivery_app/views/personal_info_screen.dart';

import '../views/info_screen.dart';
import '../views/otp_screen.dart';
import '../views/splash_screen.dart';

class RouteGenerator {
  static const String splashPage = "/";
  static const String signInPage = "/signIn";
  static const String otpPage = "/otp";
  static const String infoPage = "/info";
  static const String homePage = "/home";
  static const String personalInfoPage = "/personalInfo";
  static Route generateRoute(RouteSettings settings) {
    return switch (settings.name) {
      splashPage => MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
      signInPage => MaterialPageRoute(
          settings: settings, builder: (context) => const LoginScreen()),
      otpPage => MaterialPageRoute(
          settings: settings, builder: (context) => const OtpScreen()),
      infoPage => MaterialPageRoute(
          settings: settings, builder: (context) => const InfoScreen()),
      personalInfoPage => MaterialPageRoute(
          settings: settings, builder: (context) => const PersonalInfoScreen()),
      homePage => MaterialPageRoute(
          settings: settings, builder: (context) => const HomeScreen()),
      _ => throw const FormatException("Route not found"),
    };
  }
}
