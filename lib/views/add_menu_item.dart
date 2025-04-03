import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tumdum_delivery_app/util/extension_util.dart';

import '../model/menu_item.dart';
import '../services/fb_db_services.dart';
import '../services/image_service.dart';
import '../services/message_service.dart';
import '../util/media_utils.dart';
import '../widget/button_widget.dart';
import '../widget/text_field.dart';

class AddMenuItemScreen extends StatefulWidget {
  const AddMenuItemScreen({super.key});

  @override
  State<AddMenuItemScreen> createState() => _AddMenuItemScreenState();
}

class _AddMenuItemScreenState extends State<AddMenuItemScreen> {
  final _fKey = GlobalKey<FormState>();
  bool addDescription = false;
  MenuItem menuItem = MenuItem();
  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...menuItem.toMap().entries.toList().map(
                    (e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFieldWidget(
                          onSaved: (p0) => (p0?.trim().isNotEmpty ?? false)
                              ? menuItem.setFieldValue(e.key, p0 ?? "")
                              : {},
                          hintText: e.key.capitalizeAndSplitOnSecondCapital()),
                    ),
                  ),
              TextButton.icon(
                onPressed: () async {
                  if (menuItem.itemImage is File) {
                    setState(() => menuItem.itemImage = null);
                  } else {
                    FToast().init(context);
                    final path = await ImageService.selectImage(context);
                    if (path != null) {
                      setState(() => menuItem.itemImage = File(path));
                    }
                  }
                },
                label: Text(
                  menuItem.itemImage is File
                      ? "Item_Image.${MediaUtils.getExtension(menuItem.itemImage.path)}"
                      : "Add ItemImage",
                ),
                icon: Icon(menuItem.itemImage is File
                    ? FontAwesomeIcons.xmark
                    : FontAwesomeIcons.camera),
              ),
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
                      debugPrint(menuItem.itemDescription);
                      await FbDbService.createMenuItem(menuItem).then((val) {
                        context.loaderOverlay.hide();

                        MessageService.showSuccessMessage(
                            "Product added successfully.");
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
