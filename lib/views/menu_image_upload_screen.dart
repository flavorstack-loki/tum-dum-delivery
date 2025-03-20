import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tumdum_delivery_app/gen/assets.gen.dart';
import 'package:tumdum_delivery_app/util/media_utils.dart';

import '../model/restaurant.dart';
import '../services/fb_db_services.dart';
import '../services/message_service.dart';
import '../util/custom_input_decorator.dart';
import '../util/style.dart';

class MenuImageUploadScreen extends StatefulWidget {
  const MenuImageUploadScreen({super.key});

  @override
  State<MenuImageUploadScreen> createState() => _MenuImageUploadScreenState();
}

class _MenuImageUploadScreenState extends State<MenuImageUploadScreen> {
  Restaurant? restaurant;
  @override
  Widget build(BuildContext context) {
    final List<Restaurant> restaurants = context
        .watch<List<Restaurant>>()
        .toList()
        .where((restaurant) => (restaurant.restaurantId?.isNotEmpty ?? false))
        .toList();
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          "Upload Menu Images",
          style: Style.headlineText,
        ),
        if (restaurants.isNotEmpty)
          DropdownButtonFormField<Restaurant>(
              style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600, color: Colors.blueGrey),
              decoration:
                  CustomInputDecorator.getInputDecoration(context).copyWith(
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(10),
                hintText: "Choose a Restaurant",
              ),
              items: restaurants.map((restaurant) {
                return DropdownMenuItem<Restaurant>(
                  value: restaurant, // Use the entire object as the value
                  child: Text(restaurant.resName ?? ""), // Display the name
                );
              }).toList(),
              onChanged: (value) => setState(() => restaurant = value!)),
        const SizedBox(
          height: 50,
        ),
        if (restaurant != null)
          StreamBuilder(
              stream: FbDbService.restaurantMenuItems(
                  restaurant?.restaurantId ?? ""),
              builder: (context, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : snapshot.hasData
                      ? Column(spacing: 20, children: [
                          for (int i = 0; i < (snapshot.data?.length ?? 0); i++)
                            ListTile(
                              minLeadingWidth: 50,
                              leading: snapshot.data?[i].itemImage
                                          .toString()
                                          .isNotEmpty ??
                                      false
                                  ? CachedNetworkImage(
                                      imageUrl:
                                          snapshot.data?[i].itemImage ?? "",
                                      width: 50,
                                      progressIndicatorBuilder:
                                          (context, url, progress) => Center(
                                        child: Image.asset(
                                            Assets.images.splash.logo.path),
                                      ),
                                    )
                                  : const SizedBox(),
                              title: Text(snapshot.data?[i].itemName ?? ""),
                              trailing: ElevatedButton(
                                  onPressed: () async {
                                    FToast().init(context);
                                    final image = await MediaUtils.pickMedia(
                                        MediaSource.gallery);
                                    if (image != null) {
                                      EasyLoading.show(
                                          status: 'Loading...',
                                          maskType: EasyLoadingMaskType.black);
                                      final res = await FbDbService.uploadImage(
                                          snapshot.data![i]..itemImage = image);
                                      EasyLoading.dismiss();
                                      if (res != null) {
                                        MessageService.showSuccessMessage(
                                            "File uploaded successfully");
                                      } else {
                                        MessageService.showErrorMessage(
                                            "Error while uploading file");
                                      }
                                    }
                                  },
                                  child: const Text("Upload Image")),
                            ),
                        ])
                      : Center(
                          child: Text(
                            "No Menu Item available for ${restaurant?.resName ?? "the restaurant"}",
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        )),
      ],
    );
  }
}
