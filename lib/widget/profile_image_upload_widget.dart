import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tumdum_delivery_app/services/image_service.dart';
import 'package:tumdum_delivery_app/widget/button_widget.dart';

import '../util/color_util.dart';

class ProfileImageUploadWidget extends StatefulWidget {
  const ProfileImageUploadWidget({required this.onUpload, super.key});
  final ValueChanged<String?> onUpload;
  @override
  State<ProfileImageUploadWidget> createState() =>
      _ProfileImageUploadWidgetState();
}

class _ProfileImageUploadWidgetState extends State<ProfileImageUploadWidget> {
  String? uploadedImagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              width: 2, color: ColorUtil.primaryColor.withAlpha(50))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10)),
            child: uploadedImagePath != null
                ? Image.file(
                    File(uploadedImagePath!),
                    width: 80,
                    height: 80,
                  )
                : const Icon(
                    Icons.person,
                    size: 80,
                  ),
          ),
          ImageUploadButtonWidget(
              onPressed: () async {
                if (uploadedImagePath != null) {
                  setState(() => uploadedImagePath = null);
                  widget.onUpload(uploadedImagePath);
                } else {
                  final imagePath = await ImageService.selectImage(context);
                  if (imagePath != null) {
                    setState(() => uploadedImagePath = imagePath);
                    widget.onUpload(uploadedImagePath);
                  }
                }
              },
              uploaded: uploadedImagePath != null),
        ],
      ),
    );
  }
}
