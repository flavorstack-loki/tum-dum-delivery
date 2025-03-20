class MenuItem {
  int? addedQtyPrice;
  String? categoryName,
      id,
      itemDescription,
      itemFoodType,
      itemName,
      orderId,
      resId;
  int? quantity;
  int? itemOriginalPrice;
  bool? outofStock;
  int? itemDiscountedPrice;
  dynamic itemImage;

  MenuItem({
    this.addedQtyPrice,
    this.categoryName,
    this.orderId,
    this.id,
    this.itemImage,
    this.itemDescription,
    this.itemDiscountedPrice,
    this.itemFoodType,
    this.itemName,
    this.itemOriginalPrice,
    this.outofStock,
    this.quantity,
    this.resId,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
        addedQtyPrice: json["addedQtyPrice"],
        categoryName: json["categoryName"],
        id: json["id"],
        orderId: json["orderId"],
        itemImage: json["itemImage"],
        itemDescription: json["item_description"],
        itemDiscountedPrice: json["item_discounted_price"],
        itemFoodType: json["item_foodType"],
        itemName: json["item_name"],
        itemOriginalPrice: json["item_original_price"],
        outofStock: json["outofStock"],
        quantity: json["quantity"],
        resId: json["resId"],
      );

  Map<String, dynamic> toJson() => {
        if (quantity != null && quantity != 0 && itemOriginalPrice != null)
          "addedQtyPrice": quantity! * itemOriginalPrice!,
        "categoryName": categoryName,
        "id": id,
        if (orderId != null) "orderId": orderId,
        "itemImage": itemImage,
        "item_description": itemDescription,
        "item_discounted_price": itemDiscountedPrice,
        "item_foodType": itemFoodType,
        "item_name": itemName,
        "item_original_price": itemOriginalPrice,
        "outofStock": outofStock,
        "quantity": quantity ?? 1,
        "resId": resId,
      };
  MenuItem copyWith({
    int? addedQtyPrice,
    String? categoryName,
    String? id,
    dynamic itemImage,
    String? itemDescription,
    int? itemDiscountedPrice,
    String? itemFoodType,
    String? itemName,
    int? itemOriginalPrice,
    bool? outofStock,
    int? quantity,
    String? resId,
  }) =>
      MenuItem(
        addedQtyPrice: addedQtyPrice ?? this.addedQtyPrice,
        categoryName: categoryName ?? this.categoryName,
        id: id ?? this.id,
        itemImage: itemImage ?? this.itemImage,
        itemDescription: itemDescription ?? this.itemDescription,
        itemDiscountedPrice: itemDiscountedPrice ?? this.itemDiscountedPrice,
        itemFoodType: itemFoodType ?? this.itemFoodType,
        itemName: itemName ?? this.itemName,
        itemOriginalPrice: itemOriginalPrice ?? this.itemOriginalPrice,
        outofStock: outofStock ?? this.outofStock,
        quantity: quantity ?? this.quantity,
        resId: resId ?? this.resId,
      );
}
