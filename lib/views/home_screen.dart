import 'package:flutter/material.dart';
import 'package:tumdum_delivery_app/views/orders_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        //    bottomNavigationBar: BottomNavWidget(onTap: (index) {}),
        body: IndexedStack(
      children: [OrdersScreen()],
    ));
  }
}
