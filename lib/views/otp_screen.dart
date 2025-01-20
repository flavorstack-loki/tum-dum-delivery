import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';
import 'package:tumdum_delivery_app/util/string_constants.dart';
import 'package:tumdum_delivery_app/util/style.dart';
import 'package:tumdum_delivery_app/widget/button_widget.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  children: const [TextSpan(text: "\n +919888897777")]),
            ),
            const Text(
              "Enter OTP",
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xff78192D),
                  fontWeight: FontWeight.w700),
            ),
            OtpTextField(
                numberOfFields: 6,
                focusedBorderColor: const Color(0xff78192D),
                borderColor: const Color(0xff78192D),
                borderRadius: BorderRadius.circular(10),

                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Verification Code"),
                          content: Text('Code entered is $verificationCode'),
                        );
                      });
                }),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(
                onPressed: () => Navigator.of(context)
                    .pushNamed(RouteGenerator.personalInfoPage),
                text: "Verify OTP")
          ],
        ),
      ),
    );
  }
}
