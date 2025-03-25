import 'package:flutter/material.dart';
import 'package:tumdum_delivery_app/main.dart';
import 'package:tumdum_delivery_app/services/fb_db_services.dart';
import 'package:tumdum_delivery_app/util/string_constants.dart';
import 'package:tumdum_delivery_app/widget/menu_cart_widget.dart';

class MenuItemScreen extends StatefulWidget {
  const MenuItemScreen({super.key});

  @override
  State<MenuItemScreen> createState() => _MenuItemScreenState();
}

class _MenuItemScreenState extends State<MenuItemScreen> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FbDbService.menuItems(
                sp.getString(StringConstants.restaurantIdKeyText) ?? ""),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : snapshot.hasData
                        ? ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            addAutomaticKeepAlives: true,
                            itemBuilder: (context, index) => MenuCartWidget(
                              menuItem: snapshot.data![index],
                            ),
                          )
                        : const SizedBox()));
  }
}
