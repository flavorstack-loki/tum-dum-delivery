import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {
  const CheckboxWidget(
      {required this.title, required this.onChanged, super.key});
  final Widget title;
  final ValueChanged<bool> onChanged;

  @override
  State<CheckboxWidget> createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: widget.title,
        value: value,
        onChanged: (val) {
          setState(() => value = val!);
          widget.onChanged(val!);
        });
  }
}
