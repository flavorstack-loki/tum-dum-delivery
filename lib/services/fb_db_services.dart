import 'package:firebase_database/firebase_database.dart';

class FbDbServices {
  final DatabaseReference _locationRef =
      FirebaseDatabase.instance.ref("DeliveryAgent");
}
