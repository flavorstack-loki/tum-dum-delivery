// To parse this JSON data, do
//
//     final restaurant = restaurantFromJson(jsonString);

import 'dart:convert';

Restaurant restaurantFromJson(String str) =>
    Restaurant.fromJson(json.decode(str));

String restaurantToJson(Restaurant data) => json.encode(data.toJson());

class Restaurant {
  int? contact;
  String? email, resName, restaurantId, uId, deviceToken;

  Restaurant({
    this.contact,
    this.email,
    this.resName,
    this.restaurantId,
    this.uId,
    this.deviceToken,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
      contact: json["contact"],
      email: json["email"],
      resName: json["res_name"],
      restaurantId: json["restaurantId"],
      deviceToken: json["deviceToken"],
      uId: json["uid"]);

  Map<String, dynamic> toJson() => {"deviceToken": deviceToken};
}
