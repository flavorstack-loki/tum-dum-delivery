// To parse this JSON data, do
//
//     final customer = customerFromJson(jsonString);

import 'dart:convert';

Customer customerFromJson(String str) => Customer.fromJson(json.decode(str));

String customerToJson(Customer data) => json.encode(data.toJson());

class Customer {
  String? address, authType, email, phone, uId, firstName, lastName;
  DateTime? signUpTime;

  Customer({
    this.address,
    this.authType,
    this.email,
    this.phone,
    this.signUpTime,
    this.uId,
    this.firstName,
    this.lastName,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        address: json["address"],
        authType: json["authType"],
        email: json["email"],
        phone: json["phone"],
        signUpTime: json["signUpTime"] == null
            ? null
            : DateTime.parse(json["signUpTime"]),
        uId: json["uId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "authType": authType,
        "email": email,
        "phone": phone,
        "signUpTime": signUpTime?.toIso8601String(),
        "uId": uId,
        "firstName": firstName,
        "lastName": lastName,
      };
}
