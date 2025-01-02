import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tumdum_delivery_app/gen/assets.gen.dart';
import 'package:tumdum_delivery_app/util/style.dart';
import 'package:tumdum_delivery_app/widget/button_widget.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ExpansionTile(
          shape: const Border.fromBorderSide(BorderSide.none),

          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              const Text(
                "Order No #111250",
                style: Style.headlineText,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color(0xffF8E0C6),
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  "Pickup Pending",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
          visualDensity: const VisualDensity(horizontal: -4),

          // spacing: 10,
          // mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: const VisualDensity(horizontal: -4),
              leading: const Icon(FontAwesomeIcons.user),
              title: const Text("Aman Sharma"),
              trailing: IconButton(
                  visualDensity:
                      const VisualDensity(vertical: -4, horizontal: -4),
                  onPressed: () {},
                  icon: const CircleAvatar(
                      backgroundColor: Color(0xffF8E0C6),
                      child: Icon(
                        FontAwesomeIcons.phone,
                        size: 20,
                      ))),
            ),
            const Divider(),
            ListTile(
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              isThreeLine: true,
              leading: const Icon(FontAwesomeIcons.locationDot),
              visualDensity: const VisualDensity(horizontal: -4),
              title: const Text("Pickup Center 1"),
              subtitle: const Text(
                  "Nikhita Stores, 201/B, Nirant Apts, Andheri East 400069"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      visualDensity:
                          const VisualDensity(vertical: -4, horizontal: -4),
                      onPressed: () {},
                      icon: const CircleAvatar(
                          backgroundColor: Color(0xffF8E0C6),
                          child: Icon(
                            FontAwesomeIcons.phone,
                            size: 20,
                          ))),
                  IconButton(
                      visualDensity:
                          const VisualDensity(vertical: -4, horizontal: -4),
                      onPressed: () {},
                      icon: const CircleAvatar(
                          backgroundColor: Color(0xffF8E0C6),
                          child: Icon(
                            FontAwesomeIcons.locationArrow,
                            size: 20,
                          ))),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              minLeadingWidth: 0,
              contentPadding: EdgeInsets.zero,
              isThreeLine: true,
              leading: const Icon(FontAwesomeIcons.locationDot),
              visualDensity: const VisualDensity(horizontal: -4),
              title: const Text("Delivery"),
              subtitle: const Text(
                  "201/D, Ananta Apts, Near Jal Bhawan, Andheri 400069"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                      visualDensity:
                          const VisualDensity(vertical: -4, horizontal: -4),
                      onPressed: () {},
                      icon: const CircleAvatar(
                          backgroundColor: Color(0xffF8E0C6),
                          child: Icon(
                            FontAwesomeIcons.phone,
                            size: 20,
                          ))),
                  IconButton(
                      visualDensity:
                          const VisualDensity(vertical: -4, horizontal: -4),
                      onPressed: () {},
                      icon: const CircleAvatar(
                          backgroundColor: Color(0xffF8E0C6),
                          child: Icon(
                            FontAwesomeIcons.locationArrow,
                            size: 20,
                          ))),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              contentPadding: EdgeInsets.zero,
              minLeadingWidth: 0,
              visualDensity: const VisualDensity(horizontal: -4),
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(Assets.images.splash.logo.path)),
              title: const Text("Biriyani"),
              subtitle: const Text("Quantity:2"),
            ),
            ButtonWidget(onPressed: () {}, text: "Confirm Pickup"),
          ],
        ),
      ),
    );
  }
}
