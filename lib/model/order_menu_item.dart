// To parse this JSON data, do
//
//     final orderMenuItem = orderMenuItemFromJson(jsonString);

import 'dart:convert';

OrderMenuItem orderMenuItemFromJson(String str) =>
    OrderMenuItem.fromJson(json.decode(str));

String orderMenuItemToJson(OrderMenuItem data) => json.encode(data.toJson());

class OrderMenuItem {
  String? id,
      itemImage,
      itemDescription,
      itemFoodType,
      itemName,
      orderId,
      resId;
  int? itemDiscountedPrice, itemOriginalPrice, quantity, totalPrice;

  bool? outofStock;

  OrderMenuItem({
    this.id,
    this.itemImage,
    this.itemDescription,
    this.itemDiscountedPrice,
    this.itemFoodType,
    this.itemName,
    this.itemOriginalPrice,
    this.orderId,
    this.outofStock,
    this.quantity,
    this.resId,
    this.totalPrice,
  });

  factory OrderMenuItem.fromJson(Map<String, dynamic> json) => OrderMenuItem(
      id: json["id"],
      itemImage: json["itemImage"],
      itemDescription: json["item_description"],
      itemDiscountedPrice: json["item_discounted_price"],
      itemFoodType: json["item_foodType"],
      itemName: json["item_name"],
      itemOriginalPrice: json["item_original_price"],
      orderId: json["orderId"],
      outofStock: json["outofStock"],
      quantity: json["quantity"],
      resId: json["resId"],
      totalPrice: json["addedQtyPrice"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "itemImage": itemImage,
        "item_description": itemDescription,
        "item_discounted_price": itemDiscountedPrice,
        "item_foodType": itemFoodType,
        "item_name": itemName,
        "item_original_price": itemOriginalPrice,
        "orderId": orderId,
        "outofStock": outofStock,
        "quantity": quantity,
        "resId": resId,
      };
}
