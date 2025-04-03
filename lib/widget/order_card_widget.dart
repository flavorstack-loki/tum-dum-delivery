import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tumdum_delivery_app/gen/assets.gen.dart';
import 'package:tumdum_delivery_app/model/customer.dart';
import 'package:tumdum_delivery_app/model/customer_order.dart';
import 'package:tumdum_delivery_app/model/order_menu_item.dart';
import 'package:tumdum_delivery_app/services/fb_db_services.dart';
import 'package:tumdum_delivery_app/util/color_util.dart';
import 'package:tumdum_delivery_app/util/reference_util.dart';
import 'package:tumdum_delivery_app/util/style.dart';
import 'package:tumdum_delivery_app/widget/button_widget.dart';
import 'package:collection/collection.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({required this.order, super.key});
  final CustomerOrder order;
  @override
  Widget build(BuildContext context) {
    final customer = context.watch<List<Customer>>().toList().firstWhereOrNull(
          (element) => element.uId == order.customerId,
        );
    return StreamBuilder(
        stream: FbDbService.orderMenuItems(order.orderId ?? ""),
        builder: (ctxt, snap) {
          if (snap.hasData) {
            final orderMenuItemsList = snap.data as List<OrderMenuItem>;
            return Card(
              elevation: 3,
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: ExpansionTile(
                  showTrailingIcon: false,
                  shape: const Border.fromBorderSide(BorderSide.none),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 10,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "Order No  #${order.orderId?.substring(8)}",
                              style: Style.headlineText.copyWith(fontSize: 22),
                            ),
                          ),
                          Text(
                            DateFormat("hh:mm a")
                                .format(order.createdTime!.toDate()),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ],
                      ),
                      Row(
                        spacing: 10,
                        children: [
                          if (order.orderStatus != OrderStatus.created)
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: ColorUtil.secondaryColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                CustomerOrder.getOrderStatusString(
                                        order.orderStatus) ??
                                    "",
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          if (order.orderStatus != OrderStatus.declined &&
                              order.orderStatus != OrderStatus.completed)
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: ColorUtil.secondaryColor,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                "${order.paymentStatus == PaymentStatus.pending ? "Payment " : ""}${CustomerOrder.getPaymentStatusString(order.paymentStatus) ?? ""}",
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          const Spacer(),
                          const Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
                    ],
                  ),
                  visualDensity: const VisualDensity(horizontal: -4),
                  children: [
                    if (customer != null)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: const VisualDensity(horizontal: -4),
                        leading: const Icon(FontAwesomeIcons.user),
                        title:
                            Text("${customer.firstName} ${customer.lastName}"),
                        trailing: IconButton(
                            visualDensity: const VisualDensity(
                                vertical: -4, horizontal: -4),
                            onPressed: () async {
                              FToast().init(context);
                              final phoneNumber = "tel:${customer.phone}";
                              await ReferenceUtil.openUrl(uri: phoneNumber);
                            },
                            icon: const CircleAvatar(
                                backgroundColor: ColorUtil.secondaryColor,
                                child: Icon(
                                  FontAwesomeIcons.phone,
                                  size: 20,
                                ))),
                      ),
                    const Divider(),
                    ...orderMenuItemsList.map(
                      (e) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        minLeadingWidth: 0,
                        visualDensity: const VisualDensity(horizontal: -4),
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SvgPicture.asset(
                              Assets.images.splash.logo,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )),
                        title: Text(e.itemName ?? ""),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Quantity: ${e.quantity}"),
                            Text("Total Price: ${e.totalPrice}")
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Total Order Value: ₹${order.menuTotalPrice}.00",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (order.orderStatus != OrderStatus.completed &&
                        order.orderStatus != OrderStatus.failed &&
                        order.orderStatus != OrderStatus.declined &&
                        order.paymentStatus != PaymentStatus.unpaid)
                      ButtonWidget(
                          onPressed: () async {
                            final paymentStatus = order.paymentStatus ==
                                        PaymentStatus.pending &&
                                    order.orderStatus == OrderStatus.accepted
                                ? PaymentStatus.paid
                                : order.paymentStatus;
                            final orderStatus = order.orderStatus ==
                                    OrderStatus.created
                                ? OrderStatus.accepted
                                : order.orderStatus == OrderStatus.accepted &&
                                        order.paymentStatus ==
                                            PaymentStatus.paid
                                    ? OrderStatus.completed
                                    : order.orderStatus;
                            await FbDbService.updateOrderDetail(order
                              ..paymentStatus = paymentStatus
                              ..orderStatus = orderStatus);
                          },
                          text: order.orderStatus == OrderStatus.created
                              ? "Confirm Order"
                              : order.orderStatus == OrderStatus.accepted &&
                                      order.paymentStatus ==
                                          PaymentStatus.pending
                                  ? "Confirm Payment"
                                  : "Order Completed"),
                    if (order.paymentStatus == PaymentStatus.pending &&
                        (order.orderStatus == OrderStatus.created ||
                            order.orderStatus == OrderStatus.accepted))
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ButtonWidget(
                            onPressed: () async =>
                                await FbDbService.updateOrderDetail(order
                                  ..paymentStatus =
                                      order.orderStatus != OrderStatus.created
                                          ? PaymentStatus.unpaid
                                          : order.paymentStatus
                                  ..orderStatus =
                                      order.orderStatus == OrderStatus.created
                                          ? OrderStatus.declined
                                          : OrderStatus.failed),
                            text: order.orderStatus == OrderStatus.created
                                ? "Decline Order"
                                : "Payment Unpaid"),
                      ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        });
  }
}
