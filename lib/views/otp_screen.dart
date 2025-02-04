import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';
import 'package:tumdum_delivery_app/util/color_util.dart';
import 'package:tumdum_delivery_app/util/string_constants.dart';
import 'package:tumdum_delivery_app/util/style.dart';
import 'package:tumdum_delivery_app/widget/button_widget.dart';

import '../services/fb_auth_service.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final verificationId = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          StringConstants.otpVerificationText,
          style: Style.headlineText,
        ),
        leading: IconButton(
            onPressed: () {}, icon: const Icon(FontAwesomeIcons.arrowLeft)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 20,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: StringConstants.otpSentText,
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  children: const [
                    TextSpan(text: "\n${StringConstants.mobileHintText}")
                  ]),
            ),
            const Text(
              StringConstants.enterOtpText,
              style: TextStyle(
                  fontSize: 18,
                  color: ColorUtil.primaryColor,
                  fontWeight: FontWeight.w700),
            ),
            OtpTextField(
                numberOfFields: 6,
                focusedBorderColor: ColorUtil.primaryColor,
                borderColor: ColorUtil.primaryColor,
                borderRadius: BorderRadius.circular(10),
                showFieldAsBox: true,
                onCodeChanged: (String code) {},
                onSubmit: (String verificationCode) async {
                  final user = await FbAuthService.signInWithPhoneNumber(
                      credential: PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: verificationCode));
                  if (user != null) {
                    Navigator.of(context)
                        .pushReplacementNamed(RouteGenerator.homePage);
                  }
                }),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(RouteGenerator.personalInfoPage);
                },
                text: StringConstants.verifyOtpText)
          ],
        ),
      ),
    );
  }
}
