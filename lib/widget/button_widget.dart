import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({required this.onPressed, required this.text, super.key});
  final Function() onPressed;

  final String text;
  @override
  Widget build(BuildContext context) {
    final wh = MediaQuery.sizeOf(context).width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xff78192D),
          fixedSize: Size(wh, 60),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: onPressed,
      child: FittedBox(
        child: Text(
          text,
          maxLines: 1,
          style: const TextStyle(
              color: Color(0xffF8E0C6),
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
  final Function() onPressed;
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
