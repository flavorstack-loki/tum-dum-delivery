import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tumdum_delivery_app/model/restaurant.dart';
import 'package:tumdum_delivery_app/util/extension_util.dart';
import 'package:tumdum_delivery_app/widget/image_picker_widget.dart';

import '../services/fb_db_services.dart';
import '../services/image_service.dart';
import '../services/message_service.dart';
import '../widget/button_widget.dart';
import '../widget/text_field.dart';

class RestaurantProfileEditScreen extends StatefulWidget {
  const RestaurantProfileEditScreen({super.key});

  @override
  State<RestaurantProfileEditScreen> createState() =>
      _RestaurantProfileEditScreenState();
}

class _RestaurantProfileEditScreenState
    extends State<RestaurantProfileEditScreen> {
  final _fKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final restaurant = ModalRoute.of(context)?.settings.arguments as Restaurant;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              FontAwesomeIcons.arrowLeft,
            )),
      ),
      body: Form(
        key: _fKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...restaurant.toMap().entries.toList().map(
                    (e) => TextFieldWidget(
                        initialValue: e.value.toString(),
                        onSaved: (p0) => (p0?.trim().isNotEmpty ?? false)
                            ? restaurant.setFieldValue(e.key, p0 ?? "")
                            : {},
                        hintText: e.key.capitalizeAndSplitOnSecondCapital()),
                  ),
              const Text(
                "FSSAI",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              ImagePickerWidget(
                  onUpload: () async {
                    FToast().init(context);
                    final path = await ImageService.selectImage(context);
                    if (path != null) {
                      setState(() => restaurant.fssaiImage = File(path));
                    }
                  },
                  onDelete: () => setState(() => restaurant.fssaiImage = null),
                  imagepath: restaurant.fssaiImage is String
                      ? restaurant.fssaiImage
                      : restaurant.fssaiImage.path,
                  text: "FSSAI",
                  isUrl: restaurant.fssaiImage is String &&
                      restaurant.fssaiImage.toString().isValidUrl),
              const Text(
                "PAN",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              ImagePickerWidget(
                  onUpload: () async {
                    FToast().init(context);
                    final path = await ImageService.selectImage(context);
                    if (path != null) {
                      setState(() => restaurant.panImage = File(path));
                    }
                  },
                  onDelete: () => setState(() => restaurant.panImage = null),
                  imagepath: restaurant.panImage is String
                      ? restaurant.panImage
                      : restaurant.panImage.path,
                  text: "PAN",
                  isUrl: restaurant.panImage is String &&
                      restaurant.panImage.toString().isValidUrl),
              const Text(
                "MENU",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              ImagePickerWidget(
                  onUpload: () async {
                    FToast().init(context);
                    final path = await ImageService.selectImage(context);
                    if (path != null) {
                      setState(() => restaurant.menuListImg = File(path));
                    }
                  },
                  onDelete: () => setState(() => restaurant.menuListImg = null),
                  imagepath: restaurant.menuListImg is String
                      ? restaurant.menuListImg
                      : restaurant.menuListImg.path,
                  text: "MENU",
                  isUrl: restaurant.menuListImg is String &&
                      restaurant.menuListImg.toString().isValidUrl),
              const SizedBox(
                height: 20,
              ),
              ButtonWidget(
                  onPressed: () async {
                    final fState = _fKey.currentState!;
                    if (fState.validate()) {
                      FToast().init(context);
                      fState.save();
                      context.loaderOverlay.show();

                      await FbDbService.updateRestaurant(restaurant)
                          .then((val) {
                        context.loaderOverlay.hide();

                        MessageService.showSuccessMessage(
                            "Profile updated successfully.");
                        Navigator.of(context).pop();
                      });
                    }
                  },
                  text: "Update")
            ],
          ),
        ),
      ),
    );
  }
}
