import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tumdum_delivery_app/services/fb_db_services.dart';
import 'package:tumdum_delivery_app/services/message_service.dart';

import '../model/resturant.dart';
import '../util/string_constants.dart';

class FbAuthService {
  static final _auth = FirebaseAuth.instance;
  static Stream<User?> get fUser => _auth.authStateChanges();
  static User? get currentUser => _auth.currentUser;

  static Future<Restaurant?> signInWithEmailAndPassword(
      Restaurant restaurant) async {
    User? fuser;
    try {
      fuser = (await _auth.signInWithEmailAndPassword(
        email: restaurant.resEmail!,
        password: restaurant.pass!,
      ))
          .user;
      print(restaurant.resEmail);
      final user = await FbDbServices.getRestaurantByUid(fuser?.email);
      print(fuser?.email);
      print(user?.resEmail);
      if (user == null) {
        MessageService.showErrorMessage(
            "No Restaurant found with given credential.Please register your account.");
      }

      return user;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      MessageService.showErrorMessage(
          StringConstants.getMessageFromErrorCode(e.code));
    }
    return null;
  }

  static Future<void> verifyPhoneNumber(
      {required String phoneNumber,
      required ValueChanged<String> codeSent,
      required VoidCallback onVerificationFailed}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException e) => onVerificationFailed(),
      codeSent: (String verificationId, int? resendToken) =>
          codeSent(verificationId),
      codeAutoRetrievalTimeout: (String verificationId) {},
      timeout: const Duration(seconds: 60),
    );
  }

  static Future<User?> signInWithPhoneNumber({
    required PhoneAuthCredential credential,
  }) async {
    try {
      final userCredential = await _auth.signInWithCredential(credential);

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      MessageService.showErrorMessage(handleAuthException(e));
      print(e.message);
    } catch (e) {
      print(e);
      MessageService.showErrorMessage("Error sending OTP. Please try again.");
    }
    return null;
  }

  static Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  static String handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-verification-code':
        return ('The verification code provided is invalid.');

      case 'invalid-verification-id':
        return ('The verification ID provided is invalid.');

      case 'session-expired':
        return ('The SMS code has expired. Please resend the verification code.');

      case 'quota-exceeded':
        return ('The SMS quota for the project has been exceeded.');

      case 'too-many-requests':
        return ('Too many requests. Please try again later.');

      case 'network-request-failed':
        return ('A network error occurred. Please check your connection and try again.');

      case 'user-disabled':
        return ('The user corresponding to the given phone number has been disabled.');

      case 'operation-not-allowed':
        return ('Phone number sign-in is not enabled for this project.');

      case 'invalid-phone-number':
        return ('The provided phone number is invalid.Please add country code if not already added');

      default:
        return ('An undefined Error happened.');
    }
  }
}
