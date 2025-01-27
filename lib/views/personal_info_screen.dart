import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tumdum_delivery_app/model/employee.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';
import 'package:tumdum_delivery_app/util/date_time_util.dart';
import 'package:tumdum_delivery_app/util/string_constants.dart';
import 'package:tumdum_delivery_app/util/style.dart';
import 'package:tumdum_delivery_app/widget/button_widget.dart';
import 'package:tumdum_delivery_app/widget/profile_image_upload_widget.dart';
import 'package:tumdum_delivery_app/widget/text_field.dart';

import '../widget/info_card_widget.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Employee employee = Employee();
    final dobController = TextEditingController(),
        idDocController = TextEditingController();
    final fKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 30,
        centerTitle: false,
        leading: IconButton(
            padding: const EdgeInsets.only(left: 10),
            visualDensity: const VisualDensity(horizontal: -4),
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(FontAwesomeIcons.arrowLeft)),
        title: const Text(
          StringConstants.personalInfo,
          style: Style.headlineText,
          textAlign: TextAlign.left,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: fKey,
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
              TextFieldWidget(
                hintText: StringConstants.nameHintText,
                onSaved: (p0) => employee.name = p0,
              ),
              const Text(StringConstants.dob),
              TextFieldWidget(
                controller: dobController,
                readOnly: true,
                hintText: StringConstants.dobHintText,
                onTap: () async => await DateTimeUtil.selectDate(
                  context,
                ).then((value) => value != null
                    ? dobController.text =
                        DateFormat("dd/MM/yyyy").format(value)
                    : null),
                onSaved: (p0) => employee.dob,
              ),
              const Text(StringConstants.whatsapp),
              TextFieldWidget(
                hintText: StringConstants.mobileHintText,
                onSaved: (p0) => employee.whatsApp = p0,
              ),
              const Text(StringConstants.mobile),
              TextFieldWidget(
                hintText: StringConstants.mobileHintText,
                onSaved: (p0) => employee.mobile = p0,
              ),
              const Text(StringConstants.address),
              TextFieldWidget(
                hintText: StringConstants.addressHintText,
                onSaved: (p0) => employee.address = p0,
              ),
              const Text(StringConstants.drivingLicenseText),
              TextFieldWidget(
                hintText: StringConstants.drivingLicenseHintText,
                onSaved: (p0) => employee.dLNumber = p0,
              ),
              const Text(StringConstants.vehicleNumberText),
              TextFieldWidget(
                hintText: StringConstants.vehicleNumberHintText,
                onSaved: (p0) => employee.vehicleNumber = p0,
              ),
              const Text(StringConstants.vehicleTypeText),
              TextFieldWidget(
                hintText: StringConstants.vehicleTypeHintText,
                onSaved: (p0) => employee.vehicleType = p0,
              ),
              const Text(StringConstants.imageText),
              ProfileImageUploadWidget(
                onUpload: (value) => value != null
                    ? employee.profileImage = File(value)
                    : employee.profileImage = null,
              ),
              InfoCardWidget(
                text: StringConstants.personalDocumentsText,
                onPressed: () => Navigator.of(context)
                    .pushNamed(RouteGenerator.identityDocUploadPage),
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
      ),
    );
  }
}
