import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tumdum_delivery_app/widget/button_widget.dart';

import '../util/color_util.dart';
import '../util/style.dart';

class IdentityImageUploadScreen extends StatelessWidget {
  const IdentityImageUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Aadhaar Card Details",
          style: Style.headlineText,
        ),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(FontAwesomeIcons.arrowLeft)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            const Text(
                "Upload focused photo of your Aadhaar for faster verification"),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorUtil.primaryColor),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 15,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Front side photo of your Aadhar card with your clear name and photo",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                      width: 180,
                      child: ImageUploadButtonWidget(
                          onPressed: () {}, uploaded: false))
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorUtil.primaryColor),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                spacing: 15,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Back side photo of your Aadhar card with your address",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                      width: 180,
                      child: ImageUploadButtonWidget(
                          onPressed: () {}, uploaded: false))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
