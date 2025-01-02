import 'package:flutter/material.dart';
import 'package:tumdum_delivery_app/views/orders_screen.dart';
import 'package:tumdum_delivery_app/widget/bottom_nav_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavWidget(onTap: (index) {}),
        body: const IndexedStack(
          children: [OrdersScreen()],
        ));
  }
}
