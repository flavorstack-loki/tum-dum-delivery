import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tumdum_delivery_app/model/customer_order.dart';
import 'package:tumdum_delivery_app/util/string_constants.dart';
import 'package:tumdum_delivery_app/util/style.dart';
import 'package:tumdum_delivery_app/widget/order_card_widget.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderList = context.watch<List<CustomerOrder>>().toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          StringConstants.orderText,
          style: Style.headlineText,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: orderList.length,
        itemBuilder: (context, index) => OrderCardWidget(
          order: orderList[index],
        ),
      ),
    );
  }
}
