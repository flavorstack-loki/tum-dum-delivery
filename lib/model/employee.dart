import 'dart:convert';

enum VehicleType { bike, scooty, electric }

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
  String? name,
      whatsApp,
      mobile,
      address,
      city,
      dLNumber,
      vehicleNumber,
      vehicleType,
      identityProofNumber,
      identityProofDoc;
  dynamic profileImage;
  DateTime? dob;

  Employee({
    this.name,
    this.dob,
    this.whatsApp,
    this.mobile,
    this.identityProofNumber,
    this.address,
    this.city,
    this.dLNumber,
    this.vehicleNumber,
    this.vehicleType,
    this.identityProofDoc,
    this.profileImage,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
      name: json["name"],
      dob: DateTime.tryParse(json["dob"]),
      whatsApp: json["whatsApp"],
      mobile: json["mobile"],
      address: json["address"],
      city: json["city"],
      dLNumber: json["dLNumber"],
      identityProofNumber: json["identityProofNumber"],
      vehicleNumber: json["vehicleNumber"],
      vehicleType: json["vehicleType"],
      profileImage: json["profileImage"],
      identityProofDoc: json["identityProofDoc"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "dob": dob?.toIso8601String(),
        "whatsApp": whatsApp,
        "mobile": mobile,
        "address": address,
        "identityProofNumber": identityProofNumber,
        "city": city,
        "dLNumber": dLNumber,
        "vehicleNumber": vehicleNumber,
        "vehicleType": vehicleType,
        "profileImage": profileImage,
        "identityProofDoc": identityProofDoc
      };
}
