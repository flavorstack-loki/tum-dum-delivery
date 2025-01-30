import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:tumdum_delivery_app/model/restaurant.dart';

class FbDbService {
  static final _firestore = FirebaseFirestore.instance;

  static final _functions = FirebaseFunctions.instance;
  static final _restaurantCollection =
      _firestore.collection("registeredRestaurant");
  static Stream<List<Restaurant>> get restaurants =>
      _restaurantCollection.snapshots().map((event) =>
          event.docs.map((e) => Restaurant.fromJson(e.data())).toList());

  static Future<bool?> triggerCloudFunction(
      {required String menuJson, required String restaurantId}) async {
    try {
      // Trigger Cloud Function (use a callable function or HTTP trigger depending on your implementation)
      final result = await _functions
          .httpsCallable('processMenuItems')
          .call(<String, dynamic>{
        'restaurantId': restaurantId,
        "menuJson": menuJson,
      });
      debugPrint('Response: ${result.data}');
      return true;
    } catch (e) {
      debugPrint("Error triggering cloud function: $e");
    }
    return null;
  }
}
