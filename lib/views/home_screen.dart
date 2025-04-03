import 'package:flutter/material.dart';
import 'package:tumdum_delivery_app/navigation/routes.dart';
import 'package:tumdum_delivery_app/util/color_util.dart';
import 'package:tumdum_delivery_app/views/menu_screen.dart';
import 'package:tumdum_delivery_app/views/orders_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              leadingWidth: 150,
              leading: TextButton.icon(
                  icon: const Icon(
                    Icons.add,
                    size: 25,
                  ),
                  onPressed: () => Navigator.of(context)
                      .pushNamed(RouteGenerator.menuAddPage),
                  label: const Text(
                    "Add Menu",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              automaticallyImplyLeading: false,
              title: const Text("Home"),
              actions: [
                TextButton.icon(
                    label: const Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: ColorUtil.primaryColor),
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(RouteGenerator.restaurantProfilePage),
                    icon: const Icon(
                      Icons.person,
                      size: 30,
                    ))
              ],
              bottom: const TabBar(tabs: [
                Tab(
                  text: "Orders",
                ),
                Tab(
                  text: "Menu",
                )
              ])),
          //    bottomNavigationBar: BottomNavWidget(onTap: (index) {}),
          body: const TabBarView(
            children: [OrdersScreen(), MenuItemScreen()],
          )),
    );
  }
}
