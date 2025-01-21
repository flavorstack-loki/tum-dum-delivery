class Restaurant {
  String? resEmail, resId, resName, pass;
  double? lat, lng;
  Restaurant(
      {this.resEmail, this.resId, this.resName, this.lat, this.pass, this.lng});
  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        resName: json["res_name"],
        resEmail: json["email"],
        resId: json["restaurantId"],
      );

  Map<String, dynamic> toJson() => {"lat": lat, "lng": lng};
}
