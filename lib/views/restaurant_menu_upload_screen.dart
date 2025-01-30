import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:tumdum_delivery_app/model/restaurant.dart';
import 'package:tumdum_delivery_app/services/fb_db_services.dart';
import 'package:tumdum_delivery_app/services/message_service.dart';
import 'package:tumdum_delivery_app/util/media_utils.dart';
import 'package:tumdum_delivery_app/util/style.dart';
import 'package:tumdum_delivery_app/widget/button_widget.dart';

class RestaurantMenuUploadScreen extends StatefulWidget {
  const RestaurantMenuUploadScreen({super.key});

  @override
  State<RestaurantMenuUploadScreen> createState() =>
      _RestaurantMenuUploadScreenState();
}

class _RestaurantMenuUploadScreenState
    extends State<RestaurantMenuUploadScreen> {
  Restaurant? restaurant;
  Map<String, dynamic>? selectedItem;
  @override
  Widget build(BuildContext context) {
    final List<Restaurant> restaurants = context
        .watch<List<Restaurant>>()
        .toList()
        .where((restaurant) => (restaurant.restaurantId?.isNotEmpty ?? false))
        .toList();

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Restaurant Menu Upload",
      )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 20,
        children: [
          const Text(
            "Upload Restaurant Menu Json File",
            style: Style.headlineText,
          ),
          if (restaurants.isNotEmpty)
            DropdownButtonFormField<Restaurant>(
                decoration: const InputDecoration(
                  labelText: "Choose a Restaurant",
                  border: OutlineInputBorder(),
                ),
                value: restaurant ??
                    restaurants.last, // Default or current selection
                items: restaurants.map((restaurant) {
                  return DropdownMenuItem<Restaurant>(
                    value: restaurant, // Use the entire object as the value
                    child: Text(restaurant.resName ?? ""), // Display the name
                  );
                }).toList(),
                onChanged: (value) {
                  print(value?.restaurantId);
                  setState(() => restaurant = value!);
                }),
          Center(
            child: ButtonWidget(
                onPressed: () async {
                  FToast().init(context);
                  final (jsonFile, file) = await MediaUtils.selectJsonFile();

                  if (jsonFile != null && file != null) {
                    EasyLoading.show(
                        status: 'Loading...',
                        maskType: EasyLoadingMaskType.black);
                    final res = await FbDbService.uploadFile(
                        jsonFile: jsonFile, file: file);

                    if (res ?? false) {
                      final res2 = await FbDbService.triggerCloudFunction(
                          file.name, restaurant!.restaurantId!);
                      if (res2 ?? false) {
                        EasyLoading.dismiss();
                        MessageService.showSuccessMessage(
                            "File uploaded successfully");
                      } else {
                        EasyLoading.dismiss();
                        MessageService.showErrorMessage(
                            "Error while uploading file");
                      }
                    }
                    EasyLoading.dismiss();
                  }
                },
                text: "Pick File"),
          ),
        ],
      ),
    );
  }
}
