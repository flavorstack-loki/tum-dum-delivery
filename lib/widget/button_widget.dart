import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../util/color_util.dart';
import '../util/string_constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({required this.onPressed, required this.text, super.key});
  final VoidCallback onPressed;

  final String text;
  @override
  Widget build(BuildContext context) {
    final wh = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: ColorUtil.primaryColor,
          fixedSize: Size(wh, 60),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: onPressed,
      child: FittedBox(
        child: Text(
          text,
          maxLines: 1,
          style: const TextStyle(
              color: ColorUtil.secondaryColor,
              fontSize: 25,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class ShortButtonWidget extends StatelessWidget {
  const ShortButtonWidget(
      {required this.onPressed,
      required this.text,
      this.elevation,
      this.buttonColor,
      this.minimumSize,
      this.textColor,
      super.key});
  final VoidCallback onPressed;
  final double? elevation;
  final Color? textColor, buttonColor;
  final Size? minimumSize;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: elevation ?? 0,
            minimumSize: minimumSize ?? const Size(200, 60),
            backgroundColor: buttonColor ?? Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: textColor ?? Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ));
  }
}

class ImageUploadButtonWidget extends StatelessWidget {
  const ImageUploadButtonWidget(
      {required this.onPressed, required this.uploaded, super.key});
  final VoidCallback onPressed;
  final bool uploaded;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: ColorUtil.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            )),
        onPressed: onPressed,
        child: Row(
          spacing: 10,
          children: [
            Icon(
              uploaded ? FontAwesomeIcons.trashCan : FontAwesomeIcons.camera,
              size: 25,
            ),
            Text(
              uploaded
                  ? StringConstants.deleteText
                  : StringConstants.uploadPicText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            )
          ],
        ));
  }
}
