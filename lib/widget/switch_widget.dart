import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({required this.value, required this.onChanged, super.key});
  final bool value;
  final ValueChanged<bool> onChanged;
  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool? val;
  @override
  Widget build(BuildContext context) {
    val ??= widget.value;
    return Switch(
        value: val!,
        onChanged: (value) {
          setState(() => val = value);
          widget.onChanged(value);
        });
  }
}
