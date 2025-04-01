import 'dart:convert';

Restaurant restaurantFromJson(String str) =>
    Restaurant.fromJson(json.decode(str));

String restaurantToJson(Restaurant data) => json.encode(data.toJson());

class Restaurant {
  String? account,
      address,
      email,
      featured,
      foodCost,
      foodType,
      fssai,
      gstNumber,
      ifsc,
      ownerName,
      packagingCharges,
      panNumber,
      restaurantId,
      resName;

  dynamic fssaiImage, panImage, menuListImg;
  int? whatsappcontact;

  int? contact;
  List<CuisinesList>? cuisinesList;
  List<Day>? days;

  Restaurant({
    this.fssaiImage,
    this.panImage,
    this.account,
    this.address,
    this.contact,
    this.cuisinesList,
    this.days,
    this.restaurantId,
    this.email,
    this.featured,
    this.foodCost,
    this.foodType,
    this.fssai,
    this.gstNumber,
    this.ifsc,
    this.menuListImg,
    this.ownerName,
    this.packagingCharges,
    this.panNumber,
    this.resName,
    this.whatsappcontact,
  });

  Restaurant copyWith({
    String? account,
    address,
    email,
    foodCost,
    foodType,
    fssai,
    gstNumber,
    ifsc,
    restaurantId,
    deviceToken,
    ownerName,
    packagingCharges,
    panNumber,
    resName,
    dynamic fssaiImage,
    panImage,
    menuListImg,
    int? contact,
    List<CuisinesList>? cuisinesList,
    List<Day>? days,
    int? whatsappcontact,
  }) =>
      Restaurant(
        fssaiImage: fssaiImage ?? this.fssaiImage,
        panImage: panImage ?? this.panImage,
        account: account ?? this.account,
        address: address ?? this.address,
        contact: contact ?? this.contact,
        restaurantId: restaurantId ?? this.restaurantId,
        cuisinesList: cuisinesList ?? this.cuisinesList,
        days: days ?? this.days,
        email: email ?? this.email,
        featured: featured ?? featured,
        foodCost: foodCost ?? this.foodCost,
        foodType: foodType ?? this.foodType,
        fssai: fssai ?? this.fssai,
        gstNumber: gstNumber ?? this.gstNumber,
        ifsc: ifsc ?? this.ifsc,
        menuListImg: menuListImg ?? this.menuListImg,
        ownerName: ownerName ?? this.ownerName,
        packagingCharges: packagingCharges ?? this.packagingCharges,
        panNumber: panNumber ?? this.panNumber,
        resName: resName ?? this.resName,
        whatsappcontact: whatsappcontact ?? this.whatsappcontact,
      );

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        fssaiImage: json["FSSAIImage"],
        panImage: json["PANImage"],
        account: json["account"],
        address: json["address"],
        restaurantId: json["restaurantId"],
        contact: json["contact"],
        cuisinesList: json["cuisinesList"] == null
            ? []
            : List<CuisinesList>.from(
                json["cuisinesList"]!.map((x) => CuisinesList.fromJson(x))),
        days: json["days"] == null
            ? []
            : List<Day>.from(json["days"]!.map((x) => Day.fromJson(x))),
        email: json["email"],
        featured: json["featured"],
        foodCost: json["foodCost"],
        foodType: json["foodType"],
        fssai: json["fssai"],
        gstNumber: json["gstNumber"],
        ifsc: json["ifsc"],
        menuListImg: json["menuListImg"],
        ownerName: json["owner_name"],
        packagingCharges: json["packagingCharges"],
        panNumber: json["pan_number"],
        resName: json["res_name"],
        whatsappcontact: json["whatsappcontact"],
      );

  Map<String, dynamic> toJson() => {
        "FSSAIImage": fssaiImage,
        "PANImage": panImage,
        "account": account,
        "address": address,
        "contact": contact,
        "cuisinesList": cuisinesList == null
            ? []
            : List<dynamic>.from(cuisinesList!.map((x) => x.toJson())),
        "days": days == null
            ? []
            : List<dynamic>.from(days!.map((x) => x.toJson())),
        "email": email,
        "featured": featured,
        "foodCost": foodCost,
        "foodType": foodType,
        "fssai": fssai,
        "resataurantId": restaurantId,
        "gstNumber": gstNumber,
        "ifsc": ifsc,
        "menuListImg": menuListImg,
        "owner_name": ownerName,
        "packagingCharges": packagingCharges,
        "pan_number": panNumber,
        "res_name": resName,
        "whatsappcontact": whatsappcontact,
      };
  Map<String, dynamic> toMap() => {
        "name": resName,
        "account": account,
        "address": address,
        "contact": contact,
        "email": email,
        "featured": featured,
        "foodCost": foodCost,
        "foodType": foodType,
        "fssai": fssai,
        "gstNumber": gstNumber,
        "ifsc": ifsc,
        "ownerName": ownerName,
        "packagingCharges": packagingCharges,
        "panNumber": panNumber,
        "whatsappcontact": whatsappcontact,
      };
  void setFieldValue(String fieldName, String value) {
    switch (fieldName) {
      case 'name':
        resName = value;
        break;
      case 'account':
        account = value;
        break;
      case 'address':
        address = value;
        break;
      case 'contact':
        contact = int.tryParse(value);
        break;
      case 'email':
        email = value;
        break;
      case 'featured':
        featured = value;
        break;
      case 'foodCost':
        foodCost = value;
        break;
      case 'foodType':
        foodType = value;
        break;
      case 'fssai':
        fssai = value;
        break;
      case 'gstNumber':
        gstNumber = value;
        break;
      case 'ifsc':
        ifsc = value;
        break;
      case 'ownerName':
        ownerName = value;
        break;
      case 'packagingCharges':
        packagingCharges = value;
        break;
      case 'panNumber':
        panNumber = value;
        break;
      case 'whatsappcontact':
        whatsappcontact = int.tryParse(value);
        break;
      default:
        print('Unknown field: $fieldName');
    }
  }
}

class CuisinesList {
  int? itemId;
  String? itemText;

  CuisinesList({
    this.itemId,
    this.itemText,
  });

  CuisinesList copyWith({
    int? itemId,
    String? itemText,
  }) =>
      CuisinesList(
        itemId: itemId ?? this.itemId,
        itemText: itemText ?? this.itemText,
      );

  factory CuisinesList.fromJson(Map<String, dynamic> json) => CuisinesList(
        itemId: json["item_id"],
        itemText: json["item_text"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "item_text": itemText,
      };
}

class Day {
  String? day;
  String? openingTime;
  String? closingTime;
  bool? isClosed;
  bool? isEditable;

  Day({
    this.day,
    this.openingTime,
    this.closingTime,
    this.isClosed,
    this.isEditable,
  });

  Day copyWith({
    String? day,
    String? openingTime,
    String? closingTime,
    bool? isClosed,
    bool? isEditable,
  }) =>
      Day(
        day: day ?? this.day,
        openingTime: openingTime ?? this.openingTime,
        closingTime: closingTime ?? this.closingTime,
        isClosed: isClosed ?? this.isClosed,
        isEditable: isEditable ?? this.isEditable,
      );

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        day: json["day"],
        openingTime: json["openingTime"],
        closingTime: json["closingTime"],
        isClosed: json["isClosed"],
        isEditable: json["isEditable"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "openingTime": openingTime,
        "closingTime": closingTime,
        "isClosed": isClosed,
        "isEditable": isEditable,
      };
}
