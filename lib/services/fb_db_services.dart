import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:tumdum_delivery_app/model/menu_item.dart';
import 'package:tumdum_delivery_app/model/restaurant.dart';

class FbDbService {
  static final _firestore = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance;
  static final _functions = FirebaseFunctions.instance;
  static final _restaurantCollection =
      _firestore.collection("registeredRestaurant");
  static final _restaurantMenuCollection =
      _firestore.collection("restaurantMenu");
  static Stream<List<Restaurant>> get restaurants =>
      _restaurantCollection.snapshots().map((event) =>
          event.docs.map((e) => Restaurant.fromJson(e.data())).toList());
  static Stream<List<MenuItem>> restaurantMenuItems(String restaurantId) =>
      _restaurantMenuCollection
          .where("resId", isEqualTo: restaurantId)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => MenuItem.fromJson(e.data())).toList());
  static Future<String?> uploadImage(MenuItem menuItem) async {
    final image = menuItem.itemImage as Uint8List;

    try {
      final url = await (await _storage
              .ref("${menuItem.resId}/menuImages")
              .child(menuItem.itemName ?? "Menu")
              .putData(image))
          .ref
          .getDownloadURL();
      menuItem.itemImage = url;
      await _restaurantMenuCollection
          .doc(menuItem.id)
          .update(menuItem.toJson());

      return url;
    } on FirebaseException catch (e) {
      debugPrint(e.message);
    } catch (e) {
      debugPrint("Error:${e.toString()}");
    }
    return null;
  }

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

  static Future<void> deleteMenuItemDocuments({required String resId}) async {
    var querySnapshot =
        await _restaurantMenuCollection.where("resId", isEqualTo: resId).get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }
}
