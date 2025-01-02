import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';
import 'package:tumdum_delivery_app/util/string_constants.dart';
import 'package:tumdum_delivery_app/util/style.dart';
import 'package:tumdum_delivery_app/widget/button_widget.dart';
import 'package:tumdum_delivery_app/widget/text_field.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 30,
        centerTitle: false,
        leading: IconButton(
            padding: const EdgeInsets.only(left: 10),
            visualDensity: const VisualDensity(horizontal: -4),
            onPressed: () {},
            icon: const Icon(FontAwesomeIcons.arrowLeft)),
        title: const Text(
          StringConstants.personalInfo,
          style: Style.headlineText,
          textAlign: TextAlign.left,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              StringConstants.detailText,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const Text(StringConstants.name),
            const TextFieldWidget(
              hintText: StringConstants.nameHintText,
            ),
            const Text(StringConstants.dob),
            const TextFieldWidget(
              hintText: StringConstants.dobHintText,
            ),
            const Text(StringConstants.whatsapp),
            const TextFieldWidget(hintText: StringConstants.mobileHintText),
            const Text(StringConstants.mobile),
            const TextFieldWidget(
              hintText: StringConstants.mobileHintText,
            ),
            const Text(StringConstants.address),
            const TextFieldWidget(
              hintText: StringConstants.addressHintText,
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(
                onPressed: () =>
                    Navigator.of(context).pushNamed(RouteGenerator.homePage),
                text: StringConstants.submitText)
          ],
        ),
      ),
    );
  }
}
