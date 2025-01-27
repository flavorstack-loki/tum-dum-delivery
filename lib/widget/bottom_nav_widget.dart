import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tumdum_delivery_app/util/color_util.dart';

class BottomNavWidget extends StatefulWidget {
  const BottomNavWidget({required this.onTap, super.key});
  final Function(int) onTap;

  @override
  State<BottomNavWidget> createState() => _BottomNavWidgetState();
}

class _BottomNavWidgetState extends State<BottomNavWidget> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: ColorUtil.primaryColor),
        unselectedLabelStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.blueGrey),
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: ColorUtil.primaryColor,
        onTap: (value) {
          setState(() => index = value);
          widget.onTap(value);
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
              label: "Orders", icon: Icon(FontAwesomeIcons.bagShopping)),
          BottomNavigationBarItem(
              label: "Account", icon: Icon(FontAwesomeIcons.user)),
        ]);
  }
}
