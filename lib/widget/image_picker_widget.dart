import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget(
      {required this.onUpload,
      required this.onDelete,
      required this.imagepath,
      required this.text,
      required this.isUrl,
      super.key});
  final Function() onUpload, onDelete;
  final String? imagepath, text;
  final bool isUrl;
  @override
  Widget build(BuildContext context) {
    return imagepath != null
        ? GestureDetector(
            onTap: () => onUpload,
            child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black, width: 3)),
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(18.0),
                        child: isUrl
                            ? Image.network(
                                imagepath!,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(imagepath!),
                                fit: BoxFit.cover,
                              )),
                    IconButton(
                        alignment: Alignment.topRight,
                        onPressed: onDelete,
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 40,
                        ))
                  ],
                )))
        : TextButton.icon(
            onPressed: onUpload,
            icon: const Icon(
              FontAwesomeIcons.camera,
              color: Colors.red,
            ),
            label: Text(
              text ?? "",
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue),
            ));
  }
}
