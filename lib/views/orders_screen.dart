import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tumdum_delivery_app/main.dart';
import 'package:tumdum_delivery_app/model/customer_order.dart';
import 'package:tumdum_delivery_app/util/date_time_util.dart';
import 'package:tumdum_delivery_app/util/string_constants.dart';
import 'package:tumdum_delivery_app/util/style.dart';
import 'package:tumdum_delivery_app/widget/order_card_widget.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  DateTime dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final orderList = context
        .watch<List<CustomerOrder>>()
        .toList()
        .where((e) =>
            DateUtils.isSameDay(e.createdTime!.toDate(), dateTime) &&
            e.resId == sp.getString(StringConstants.restaurantIdKeyText))
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: const Text(
          StringConstants.orderText,
          style: Style.headlineText,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
              onPressed: () async =>
                  await DateTimeUtil.selectDate(context, initialDate: dateTime)
                      .then((date) =>
                          date != null ? setState(() => dateTime = date) : {}),
              child: Text(
                DateFormat("dd/MM/yyyy").format(dateTime),
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
              ),
            ),
          )
        ],
      ),
      body: orderList.isEmpty
          ? Center(
              child: Text(
              "NO ORDER RECEIVED ON\n${DateFormat("dd/MM/yyyy").format(dateTime)}",
              style: Style.headlineText,
              textAlign: TextAlign.center,
            ))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemCount: orderList.length,
              shrinkWrap: true,
              addAutomaticKeepAlives: true,
              itemBuilder: (context, index) => OrderCardWidget(
                order: orderList[index],
              ),
            ),
    );
  }
}
