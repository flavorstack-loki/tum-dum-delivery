import 'package:flutter/material.dart';

//import '../utils/reference_utils.dart';

class CustomInputDecorator {
  static InputDecoration getInputDecoration(BuildContext context,
      [bool invert = false]) {
    const border = OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        borderSide: BorderSide(
            color: Color(
              0xFFDDDDDD,
            ),
            width: 0.5));
    const style = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    return InputDecoration(
      focusedBorder: border,
      enabledBorder: border,
      errorBorder: border.copyWith(
          borderSide: const BorderSide(color: Colors.red, width: 1)),
      focusedErrorBorder: border.copyWith(
          borderSide: const BorderSide(color: Colors.black, width: 0.5)),
      contentPadding: const EdgeInsets.symmetric(vertical: 5),
      counterStyle: style,
      suffixStyle: style,
      errorStyle: style.copyWith(fontWeight: FontWeight.bold),
      helperStyle: style,
      hintStyle: style.copyWith(color: Colors.blueGrey),
      alignLabelWithHint: true,
      labelStyle: style.copyWith(fontWeight: FontWeight.bold),
      prefixStyle: style,
    );
  }
}
