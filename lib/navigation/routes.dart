import 'package:flutter/material.dart';
import 'package:tumdum_delivery_app/views/home_screen.dart';
import 'package:tumdum_delivery_app/views/identity_image_upload_screen.dart';
import 'package:tumdum_delivery_app/views/login_screen.dart';
import 'package:tumdum_delivery_app/views/personal_info_screen.dart';
import 'package:tumdum_delivery_app/views/restaurant_menu_upload_screen.dart';

import '../views/otp_screen.dart';
import '../views/splash_screen.dart';

class RouteGenerator {
  static const String splashPage = "/";
  static const String signInPage = "/signIn";
  static const String otpPage = "/otp";
  static const String homePage = "/home";
  static const String personalInfoPage = "/personalInfo";
  static const String identityDocUploadPage = "/identityDocUpload";
  static const String restaurantMenuUploadPage = "/restaurantMenuUpload";
  static Route generateRoute(RouteSettings settings) {
    return switch (settings.name) {
      splashPage => MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
      signInPage => MaterialPageRoute(
          settings: settings, builder: (context) => const LoginScreen()),
      otpPage => MaterialPageRoute(
          settings: settings, builder: (context) => const OtpScreen()),
      personalInfoPage => MaterialPageRoute(
          settings: settings, builder: (context) => const PersonalInfoScreen()),
      homePage => MaterialPageRoute(
          settings: settings, builder: (context) => const HomeScreen()),
      identityDocUploadPage => MaterialPageRoute(
          settings: settings,
          builder: (context) => const IdentityImageUploadScreen()),
      restaurantMenuUploadPage => MaterialPageRoute(
          settings: settings,
          builder: (context) => const RestaurantMenuUploadScreen()),
      _ => throw const FormatException("Route not found"),
    };
  }
}
