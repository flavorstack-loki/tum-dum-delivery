import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../util/custom_input_decorator.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {this.controller,
      this.onSaved,
      this.value,
      this.hintText,
      this.textInputType,
      this.onTap,
      this.validator,
      this.isPhone,
      this.optional,
      this.dropdownItems,
      this.isAadhaar,
      this.isPan,
      this.maxLines,
      this.onChanged,
      this.isEmail,
      this.suffixIcon,
      this.readOnly,
      this.initialValue,
      this.obscureText,
      this.onObscureIconTap,
      super.key});
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final String? hintText, initialValue, value;
  final TextInputType? textInputType;
  final Function()? onTap;
  final bool? readOnly,
      isPhone,
      obscureText,
      isAadhaar,
      isPan,
      isEmail,
      optional;
  final List<String>? dropdownItems;
  final Function(String? str)? onChanged;
  final String? Function(String? str)? validator;
  final Widget? suffixIcon;
  final Function()? onObscureIconTap;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return dropdownItems != null
        ? DropdownButtonFormField(
            onSaved: onSaved,
            value: value,
            menuMaxHeight: 300,
            validator: validator ??
                (value) => ((optional ?? false) &&
                        (value?.toString().trim().isEmpty ?? true))
                    ? null
                    : (value == null || value.toString().trim().isEmpty)
                        ? "Cannot be empty!"
                        : null,
            items: dropdownItems!
                .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black),
                        )))
                .toList(),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey,
            ),
            decoration:
                CustomInputDecorator.getInputDecoration(context).copyWith(
              labelText: hintText,
              contentPadding: const EdgeInsets.all(10),
            ),
            onChanged: onChanged ?? onSaved)
        : TextFormField(
            maxLines: maxLines,
            textAlignVertical: TextAlignVertical.top,
            style: const TextStyle(
              fontSize: 16.5,
              fontWeight: FontWeight.bold,
            ),
            inputFormatters: [
              if (isPhone ?? false) LengthLimitingTextInputFormatter(13),
              if (isAadhaar ?? false) LengthLimitingTextInputFormatter(12),
              if (isPan ?? false) LengthLimitingTextInputFormatter(10)
            ],
            initialValue: initialValue,
            readOnly: readOnly ?? false,
            obscureText: obscureText ?? false,
            keyboardType: textInputType,
            validator: validator ??
                (value) => ((optional ?? false) && value!.trim().isEmpty)
                    ? null
                    : (isPhone ?? false)
                        ? validateMobile(value!)
                        : (isAadhaar ?? false)
                            ? validateAadharcard(value!)
                            : (isPan ?? false)
                                ? validatePancard(value!)
                                : (isEmail ?? false)
                                    ? validateEmail(value!)
                                    : value!.trim().isEmpty
                                        ? "Cannot be empty!"
                                        : null,
            controller: controller,
            onSaved: onSaved,
            onTap: onTap,
            decoration:
                CustomInputDecorator.getInputDecoration(context).copyWith(
              hintText: hintText,
              prefixText: (isPhone ?? false) ? "+91 " : null,
              suffixIconColor: Colors.grey,
              hintMaxLines: 5,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              suffixIcon: obscureText != null
                  ? IconButton(
                      onPressed: onObscureIconTap,
                      icon: Icon(
                        (obscureText ?? false)
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        color: Colors.grey,
                        size: 20,
                      ),
                    )
                  : suffixIcon,
            ));
  }

  String? validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  String? validateAadharcard(String value) {
    String pattern = r'^\d{4}\d{4}\d{4}$';
    RegExp regExp = RegExp(pattern);
    print(regExp.stringMatch(value));
    if (!regExp.hasMatch(value)) {
      return 'Please Enter Valid Aadhar card Number';
    }

    return null;
  }

  String? validatePancard(String value) {
    String pattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please Enter Valid Pancard Number';
    }
    return null;
  }

  String? validateEmail(String value) {
    String pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$';

    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please Enter Valid Email';
    }
    return null;
  }
}
