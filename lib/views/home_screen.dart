import 'package:flutter/material.dart';
import 'package:tumdum_delivery_app/views/menu_image_upload_screen.dart';
import 'package:tumdum_delivery_app/views/restaurant_menu_upload_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: "Upload Menu Restaurant Data",
                  ),
                  Tab(
                    text: "Upload Menu Item Image",
                  )
                ],
              ),
            ),
            body: const TabBarView(children: [
              RestaurantMenuUploadScreen(),
              MenuImageUploadScreen()
            ])));
  }
}
