import 'package:flutter/material.dart';
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
              automaticallyImplyLeading: false,
              title: const Text("Home"),
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
