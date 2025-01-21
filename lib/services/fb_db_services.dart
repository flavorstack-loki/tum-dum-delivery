import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tumdum_delivery_app/model/resturant.dart';
import 'package:collection/collection.dart';

class FbDbServices {
  final DatabaseReference _locationRef =
      FirebaseDatabase.instance.ref("DeliveryAgent");
  static final _firestore = FirebaseFirestore.instance;
  static final _restaurantCollection =
      _firestore.collection("registeredRestaurant");
  static Stream<List<Restaurant>> get resturants =>
      _restaurantCollection.snapshots().map((event) =>
          event.docs.map((e) => Restaurant.fromJson(e.data())).toList());
  static Future<Restaurant?> getRestaurantByUid(String? uid) async =>
      (await resturants.first)
          .firstWhereOrNull((element) => element.resEmail == uid);
  static Future<void> updateRestaurantDetail(Restaurant restaurant) async =>
      await _restaurantCollection
          .doc(restaurant.resId)
          .update(restaurant.toJson());
}
