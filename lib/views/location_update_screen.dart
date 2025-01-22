import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tumdum_delivery_app/model/resturant.dart';
import 'package:tumdum_delivery_app/services/fb_db_services.dart';
import 'package:tumdum_delivery_app/widget/button_widget.dart';

import '../services/location_services.dart';
import '../services/message_service.dart';
import '../util/style.dart';

class LocationUpdateScreen extends StatelessWidget {
  const LocationUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final restaurant = ModalRoute.of(context)?.settings.arguments as Restaurant;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        automaticallyImplyLeading: false,
        title: const Text(
          "Update Location",
          style: Style.headlineText,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            Text(
              restaurant.resName ?? "",
              style: Style.headlineText,
            ),
            const Text(
              "For Delivery Agents to navigate to your restaurant correctly, you need to provide us your restaurant location.Follow the steps below to update your restaurant location:",
              style: TextStyle(fontSize: 18),
            ),
            const Text(
              "1. Turn on your device Location/GPS if you haven't already.",
              style:
                  TextStyle(decoration: TextDecoration.underline, fontSize: 17),
            ),
            const Text(
              "2.Make sure you are present at your Restaurant while updating the location.",
              style:
                  TextStyle(decoration: TextDecoration.underline, fontSize: 17),
            ),
            const Text(
              "3.Click on the button below to update your restaurant location.",
              style:
                  TextStyle(decoration: TextDecoration.underline, fontSize: 17),
            ),
            Align(
              alignment: Alignment.center,
              child: Center(
                child: ButtonWidget(
                    onPressed: () async {
                      FToast().init(context);
                      //   context.loaderOverlay.show();
                      final bool locationAllowed =
                          await LocationServices.locationPermission();

                      if (locationAllowed) {
                        final location =
                            await LocationServices.getCurrentLocation();
                        await FbDbServices.updateRestaurantDetail(restaurant
                              ..lat = location.latitude
                              ..lng = location.longitude)
                            .then((_) {
                          if (context.mounted) {
                            //     context.loaderOverlay.hide();
                            MessageService.showSuccessMessage(
                                "Restaurant location updated successfully");
                          }
                        });
                      } else {
                        if (context.mounted) {
                          //   context.loaderOverlay.hide();
                          MessageService.showErrorMessage(
                              "Please enable location permisson to update your Restaurant Location.");
                        }
                      }
                    },
                    text: "Update Restaurant Location"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
