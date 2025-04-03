import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:tumdum_delivery_app/main.dart';
import 'package:tumdum_delivery_app/model/customer.dart';
import 'package:tumdum_delivery_app/model/restaurant.dart';
import 'package:collection/collection.dart';
import 'package:tumdum_delivery_app/model/restaurant_user.dart';
import 'package:tumdum_delivery_app/util/string_constants.dart';

import '../model/customer_order.dart';
import '../model/menu_item.dart';
import '../model/order_menu_item.dart';

class FbDbService {
  static final _firestore = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance;
  static final _restaurantUserCollection =
      _firestore.collection("signedUpRestaurant");
  static final _customerOrderCollection =
      _firestore.collection("customerOrders");
  static final _orderMenuItemsCollection =
      _firestore.collection("orderMenuItems");
  static final _restaurantMenuItemsCollection =
      _firestore.collection("restaurantMenu");
  static final _customerCollection = _firestore.collection("registeredUser");
  static final _restaurantCollection =
      _firestore.collection("registeredRestaurant");
  static Stream<List<RestaurantUser>> get restaurantUsers =>
      _restaurantUserCollection.snapshots().map((event) =>
          event.docs.map((e) => RestaurantUser.fromJson(e.data())).toList());
  static Stream<List<Restaurant>> get restaurants =>
      _restaurantCollection.snapshots().map((event) =>
          event.docs.map((e) => Restaurant.fromJson(e.data())).toList());

  static String get _createId =>
      DateFormat('yyyyMMddHHmmssS').format(DateTime.now());
  static Future<void> updateRestaurantUserDetail(
      RestaurantUser restaurantUser) async {
    final deviceToken = await FirebaseMessaging.instance.getToken();
    if (restaurantUser.deviceToken != deviceToken) {
      restaurantUser.deviceToken = deviceToken;
      debugPrint(restaurantUser.resturantId);
      await _restaurantUserCollection
          .doc(restaurantUser.uid)
          .update(restaurantUser.toJson());
    }
  }

  static Future<void> updateRestaurant(Restaurant res) async {
    final menuListImage = res.menuListImg;
    final fssaiImage = res.fssaiImage;
    final panCardImage = res.panImage;

    if (menuListImage is File) {
      final url = await (await _storage
              .ref(res.restaurantId)
              .child("resMenuImage")
              .putFile(menuListImage))
          .ref
          .getDownloadURL();
      res.menuListImg = url;
    }
    if (fssaiImage is File) {
      final fssaiUrl = await (await _storage
              .ref(res.restaurantId)
              .child("resFSSAIImage")
              .putFile(fssaiImage))
          .ref
          .getDownloadURL();
      res.fssaiImage = fssaiUrl;
    }
    if (panCardImage is File) {
      final panCardUrl = await (await _storage
              .ref(res.restaurantId)
              .child("resPANImage")
              .putFile(panCardImage))
          .ref
          .getDownloadURL();
      res.panImage = panCardUrl;
    }
    await _restaurantCollection
        .doc(sp.getString(StringConstants.restaurantIdKeyText))
        .update(res.toJson());
  }

  static Future<bool> restaurantUserExists(String? email) async =>
      (await restaurantUsers.first).any((element) => element.email == email);
  static Future<RestaurantUser?> getRestaurantByUid(String? email) async =>
      (await restaurantUsers.first)
          .firstWhereOrNull((element) => element.email == email);

  static Stream<List<CustomerOrder>> get customerOrders =>
      _customerOrderCollection
          .where('res_id',
              isEqualTo: sp.getString(StringConstants.restaurantIdKeyText))
          .orderBy('created_time', descending: true)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => CustomerOrder.fromJson(e.data())).toList());
  static Stream<List<OrderMenuItem>> orderMenuItems(String orderId) =>
      _orderMenuItemsCollection
          .where("orderId", isEqualTo: orderId)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => OrderMenuItem.fromJson(e.data())).toList());
  static Stream<List<MenuItem>> menuItems(String resId) =>
      _restaurantMenuItemsCollection
          .where("resId", isEqualTo: resId)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => MenuItem.fromJson(e.data())).toList());
  static Future<void> updateOrderDetail(CustomerOrder order) async =>
      await _customerOrderCollection.doc(order.orderId).update(order.toJson());
  static Future<void> updateMenuItem(MenuItem menuItem) async =>
      await _restaurantMenuItemsCollection
          .doc(menuItem.id)
          .update(menuItem.toJson());
  static Future<void> createMenuItem(MenuItem menuItem) async =>
      await _restaurantMenuItemsCollection
          .doc((menuItem
                ..id = _createId
                ..resId = sp.getString(StringConstants.restaurantIdKeyText))
              .id)
          .set(menuItem.toJson());
  static Stream<List<Customer>> get customers =>
      _customerCollection.snapshots().map((event) =>
          event.docs.map((e) => Customer.fromJson(e.data())).toList());
}
