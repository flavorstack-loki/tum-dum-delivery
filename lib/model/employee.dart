// To parse this JSON data, do
//
//     final employee = employeeFromJson(jsonString);

import 'dart:convert';

Employee employeeFromJson(String str) => Employee.fromJson(json.decode(str));

String employeeToJson(Employee data) => json.encode(data.toJson());

class Employee {
  final String name, whatsApp, mobile, address;
  final DateTime? dob;

  Employee({
    required this.name,
    required this.dob,
    required this.whatsApp,
    required this.mobile,
    required this.address,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        name: json["name"],
        dob: DateTime.tryParse(json["dob"]),
        whatsApp: json["whatsApp"],
        mobile: json["mobile"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "dob": dob?.toIso8601String(),
        "whatsApp": whatsApp,
        "mobile": mobile,
        "address": address,
      };
}
