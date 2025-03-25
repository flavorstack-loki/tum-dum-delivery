class MenuItem {
  String? categoryName,
      id,
      itemDescription,
      itemFoodType,
      itemName,
      orderId,
      resId;

  int? itemOriginalPrice;
  bool? outofStock;
  int? itemDiscountedPrice;
  dynamic itemImage;

  MenuItem({
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
    this.resId,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) => MenuItem(
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
        resId: json["resId"],
      );

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "id": id,
        "itemImage": itemImage,
        "item_description": itemDescription,
        "item_discounted_price": itemDiscountedPrice,
        "item_foodType": itemFoodType,
        "item_name": itemName,
        "item_original_price": itemOriginalPrice,
        "outofStock": outofStock,
        "resId": resId,
      };
  Map<String, dynamic> toMap() => {
        "categoryName": categoryName,
        "item_description": itemDescription,
        "item_discounted_price": itemDiscountedPrice,
        "item_foodType": itemFoodType,
        "item_name": itemName,
        "item_original_price": itemOriginalPrice,
      };
  MenuItem copyWith({
    String? categoryName,
    String? id,
    String? itemImage,
    String? itemDescription,
    int? itemDiscountedPrice,
    String? itemFoodType,
    String? itemName,
    int? itemOriginalPrice,
    bool? outofStock,
    String? resId,
  }) =>
      MenuItem(
        categoryName: categoryName ?? this.categoryName,
        id: id ?? this.id,
        itemImage: itemImage ?? this.itemImage,
        itemDescription: itemDescription ?? this.itemDescription,
        itemDiscountedPrice: itemDiscountedPrice ?? this.itemDiscountedPrice,
        itemFoodType: itemFoodType ?? this.itemFoodType,
        itemName: itemName ?? this.itemName,
        itemOriginalPrice: itemOriginalPrice ?? this.itemOriginalPrice,
        outofStock: outofStock ?? this.outofStock,
        resId: resId ?? this.resId,
      );
  void setFieldValue(String fieldName, String value) {
    switch (fieldName) {
      case 'categoryName':
        categoryName = value;
        break;
      case 'item_description':
        itemDescription = value;
        break;
      case 'item_discounted_price':
        itemDiscountedPrice = int.tryParse(value);
        break;

      case 'item_original_price':
        itemOriginalPrice = int.tryParse(value);
      case 'item_name':
        itemName = value;
        break;
      case 'item_food_type':
        itemFoodType = value;
        break;
    }
  }
}
