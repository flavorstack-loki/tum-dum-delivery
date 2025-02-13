import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tumdum_delivery_app/main.dart';
import 'package:tumdum_delivery_app/model/customer.dart';
import 'package:tumdum_delivery_app/model/restaurant.dart';
import 'package:collection/collection.dart';
import 'package:tumdum_delivery_app/util/string_constants.dart';

import '../model/customer_order.dart';
import '../model/order_menu_item.dart';

class FbDbService {
  static final _firestore = FirebaseFirestore.instance;

  static final _restaurantUserCollection =
      _firestore.collection("signedUpRestaurant");
  static final _customerOrderCollection =
      _firestore.collection("customerOrders");
  static final _orderMenuItemsCollection =
      _firestore.collection("orderMenuItems");
  static final _customerCollection = _firestore.collection("registeredUser");
  static Stream<List<Restaurant>> get restaurantUsers =>
      _restaurantUserCollection.snapshots().map((event) =>
          event.docs.map((e) => Restaurant.fromJson(e.data())).toList());
  static Future<void> updateRestaurantUserDetail(Restaurant restaurant) async {
    final deviceToken = await FirebaseMessaging.instance.getToken();
    if (restaurant.deviceToken != deviceToken) {
      restaurant.deviceToken = deviceToken;

      await _restaurantUserCollection
          .doc(restaurant.uId)
          .update(restaurant.toJson());
    }
  }

  static Future<bool> restaurantUserExists(String? email) async =>
      (await restaurantUsers.first).any((element) => element.email == email);
  static Future<Restaurant?> getRestaurantByUid(String? email) async =>
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
  static Future<void> updateOrderDetail(CustomerOrder order) async =>
      await _customerOrderCollection.doc(order.orderId).update(order.toJson());

  static Stream<List<Customer>> get customers =>
      _customerCollection.snapshots().map((event) =>
          event.docs.map((e) => Customer.fromJson(e.data())).toList());
}
