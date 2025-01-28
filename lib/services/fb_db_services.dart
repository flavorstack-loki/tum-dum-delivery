import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tumdum_delivery_app/model/restaurant.dart';

class FbDbService {
  static final _firestore = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance;
  static final _functions = FirebaseFunctions.instance;
  static final _restaurantCollection =
      _firestore.collection("registeredRestaurant");
  static Stream<List<Restaurant>> get restaurants =>
      _restaurantCollection.snapshots().map((event) =>
          event.docs.map((e) => Restaurant.fromJson(e.data())).toList());
  static Future<bool?> uploadFile(
      {required Uint8List jsonFile, required PlatformFile file}) async {
    // Pick the JSON file from local storage

    // Upload to Firebase Storage
    try {
      final storageRef = _storage.ref("Restaurant Menu Files").child(file.name);

      await storageRef.putData(jsonFile);
      print('File uploaded successfully!');
      return true;

      // After uploading, trigger Cloud Function
    } catch (e) {
      print("Error uploading file: $e");
    }
    return null;
  }

  static Future<bool?> triggerCloudFunction(
      String fileName, String restaurantId) async {
    try {
      // Trigger Cloud Function (use a callable function or HTTP trigger depending on your implementation)

      final result = await _functions
          .httpsCallable('processMenuItems')
          .call(<String, dynamic>{
        'fileName': fileName, // Pass the file name to the function
        'restaurantId': restaurantId,
      });
      print('Cloud function triggered successfully: $result');
      print('Response: ${result.data}');
      return true;
    } catch (e) {
      print("Error triggering cloud function: $e");
    }
    return null;
  }
}
