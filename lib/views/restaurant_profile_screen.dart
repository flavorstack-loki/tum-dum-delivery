import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:tumdum_delivery_app/main.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';
import 'package:tumdum_delivery_app/util/extension_util.dart';
import 'package:tumdum_delivery_app/util/string_constants.dart';
import 'package:tumdum_delivery_app/widget/button_widget.dart';
import 'package:tumdum_delivery_app/widget/image_widget.dart';
import '../model/restaurant.dart';

class RestaurantProfileScreen extends StatelessWidget {
  const RestaurantProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurant = context.watch<List<Restaurant>>().firstWhereOrNull((e) =>
        e.restaurantId == sp.getString(StringConstants.restaurantIdKeyText));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              ...restaurant?.toMap().entries.toList().map((e) => Text.rich(
                        TextSpan(
                            text:
                                "${e.key.capitalizeAndSplitOnSecondCapital()} ",
                            children: [
                              TextSpan(
                                  text: "- ${e.value}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal))
                            ]),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      )) ??
                  [],
              if (restaurant?.fssaiImage.toString().isValidUrl ?? false) ...[
                const Text(
                  "FSSAI",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                ImageWidget(link: restaurant?.fssaiImage)
              ],
              if (restaurant?.panImage.toString().isValidUrl ?? false) ...[
                const Text(
                  "PAN",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                ImageWidget(link: restaurant?.panImage),
              ],
              if (restaurant?.menuListImg.toString().isValidUrl ?? false) ...[
                const Text(
                  "MENU",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                ImageWidget(link: restaurant?.menuListImg)
              ],
              ButtonWidget(
                  onPressed: () => Navigator.of(context).pushNamed(
                      RouteGenerator.restaurantProfileEditPage,
                      arguments: restaurant),
                  text: "Edit")
            ],
          ),
        ),
      ),
    );
  }
}
