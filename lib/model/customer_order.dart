import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tumdum_delivery_app/model/order_menu_item.dart';
import 'package:collection/collection.dart';

enum OrderStatus { created, accepted, declined, failed, completed }

enum PaymentStatus { pending, paid, unpaid }

class CustomerOrder {
  dynamic createdTime;
  String? customerId, orderId, resId, categoryName;
  OrderStatus orderStatus;
  PaymentStatus paymentStatus;
  int? menuTotalPrice, menuTotalQuantity;
  final List<OrderMenuItem> items;
  CustomerOrder(
      {this.createdTime,
      this.customerId,
      this.menuTotalPrice,
      this.menuTotalQuantity,
      this.orderId,
      this.orderStatus = OrderStatus.created,
      this.paymentStatus = PaymentStatus.pending,
      this.resId,
      this.categoryName,
      this.items = const []});

  factory CustomerOrder.fromJson(
    Map<String, dynamic> json,
  ) =>
      CustomerOrder(
        createdTime: json["created_time"] == null
            ? null
            : (json["created_time"] as Timestamp).toDate(),
        customerId: json["customer_id"],
        menuTotalPrice: json["menu_total_price"],
        menuTotalQuantity: json["menu_total_quantity"],
        orderId: json["order_id"],
        orderStatus: OrderStatus.values.firstWhereOrNull(
                (e) => getOrderStatusString(e) == json["order_status"]) ??
            OrderStatus.created,
        paymentStatus: PaymentStatus.values.firstWhereOrNull(
                (e) => getPaymentStatusString(e) == json["paymentStatus"]) ??
            PaymentStatus.pending,
        resId: json["res_id"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "order_status": getOrderStatusString(orderStatus),
        "paymentStatus": getPaymentStatusString(paymentStatus),
        "updated_time": DateTime.now().toIso8601String()
      };
  static String? getPaymentStatusString(PaymentStatus? paymentStatus) =>
      switch (paymentStatus) {
        PaymentStatus.pending => "Pending",
        PaymentStatus.paid => "Paid",
        PaymentStatus.unpaid => "Unpaid",
        _ => null
      };
  static String? getOrderStatusString(OrderStatus? orderStatus) =>
      switch (orderStatus) {
        OrderStatus.created => "Created",
        OrderStatus.accepted => "Accepted",
        OrderStatus.declined => "Declined",
        OrderStatus.completed => "Completed",
        OrderStatus.failed => "Failed",
        _ => null
      };
}
