import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tumdum_delivery_app/model/restaurant.dart';
import 'package:tumdum_delivery_app/services/fb_db_services.dart';
import 'package:tumdum_delivery_app/services/message_service.dart';
import 'package:tumdum_delivery_app/util/custom_input_decorator.dart';
import 'package:tumdum_delivery_app/util/style.dart';
import 'package:tumdum_delivery_app/widget/button_widget.dart';
import 'package:tumdum_delivery_app/widget/text_field.dart';

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
  final _fKey = GlobalKey<FormState>();
  final _menuController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final List<Restaurant> restaurants = context
        .watch<List<Restaurant>>()
        .toList()
        .where((restaurant) => (restaurant.restaurantId?.isNotEmpty ?? false))
        .toList();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _fKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 20,
            children: [
              const Text(
                "Upload Restaurant Menu Data",
                style: Style.headlineText,
              ),
              TextFieldWidget(
                textInputType: TextInputType.multiline,
                maxLines: 10,
                controller: _menuController,
                hintText: "Menu Json Data",
              ),
              if (restaurants.isNotEmpty)
                DropdownButtonFormField<Restaurant>(
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w600, color: Colors.blueGrey),
                    decoration: CustomInputDecorator.getInputDecoration(context)
                        .copyWith(
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(10),
                      hintText: "Choose a Restaurant",
                    ),
                    items: restaurants.map((restaurant) {
                      return DropdownMenuItem<Restaurant>(
                        value: restaurant, // Use the entire object as the value
                        child:
                            Text(restaurant.resName ?? ""), // Display the name
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => restaurant = value!)),
              Center(
                child: ButtonWidget(
                    onPressed: () async {
                      FToast().init(context);
                      final fState = _fKey.currentState;
                      if (fState!.validate()) {
                        EasyLoading.show(
                            status: 'Loading...',
                            maskType: EasyLoadingMaskType.black);

                        final res2 = await FbDbService.triggerCloudFunction(
                            menuJson: _menuController.text,
                            restaurantId: restaurant!.restaurantId!);
                        if (res2 ?? false) {
                          EasyLoading.dismiss();
                          MessageService.showSuccessMessage(
                              "File uploaded successfully");
                        } else {
                          EasyLoading.dismiss();
                          MessageService.showErrorMessage(
                              "Error while uploading file");
                        }

                        EasyLoading.dismiss();
                      }
                    },
                    text: "Upload Menu"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
