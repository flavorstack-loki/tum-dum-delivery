import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

RestaurantUser restaurantUserFromJson(String str) =>
    RestaurantUser.fromJson(json.decode(str));

String restaurantUserToJson(RestaurantUser data) => json.encode(data.toJson());

class RestaurantUser {
  String? authType;
  String? deleted;
  String? email;
  String? resturantId;
  String? role;
  Timestamp? signUpTime;
  String? uid;
  String? userName;
  String? deviceToken;

  RestaurantUser({
    this.authType,
    this.deleted,
    this.email,
    this.resturantId,
    this.role,
    this.signUpTime,
    this.uid,
    this.userName,
    this.deviceToken,
  });

  RestaurantUser copyWith({
    String? authType,
    String? deleted,
    String? email,
    String? resturantId,
    String? role,
    Timestamp? signUpTime,
    String? uid,
    String? userName,
    String? deviceToken,
  }) =>
      RestaurantUser(
        authType: authType ?? this.authType,
        deleted: deleted ?? this.deleted,
        email: email ?? this.email,
        resturantId: resturantId ?? this.resturantId,
        role: role ?? this.role,
        signUpTime: signUpTime ?? this.signUpTime,
        uid: uid ?? this.uid,
        userName: userName ?? this.userName,
        deviceToken: deviceToken ?? this.deviceToken,
      );

  factory RestaurantUser.fromJson(Map<String, dynamic> json) => RestaurantUser(
        authType: json["authType"],
        deleted: json["deleted"],
        email: json["email"],
        resturantId: json["resturantId"],
        role: json["role"],
        signUpTime: json["signUpTime"],
        uid: json["uid"],
        userName: json["userName"],
        deviceToken: json["deviceToken"],
      );

  Map<String, dynamic> toJson() => {
        "authType": authType,
        "deleted": deleted,
        "email": email,
        "resturantId": resturantId,
        "role": role,
        "signUpTime": signUpTime,
        "uid": uid,
        "userName": userName,
        "deviceToken": deviceToken,
      };
}
