

import 'package:neostore/product/model/product_model/product_model.dart';

class OrderSummaryModel {
  String? id;
  User? user;
  int? createdOn;
  double? tax;
  double? discount;
  double? subTotal;
  double? total;
  String? status;
  Address? address;
  int? v;
  List<ProductModel>? products;

  OrderSummaryModel({
    this.id,
    this.user,
    this.createdOn,
    this.tax,
    this.discount,
    this.subTotal,
    this.total,
    this.status,
    this.address,
    this.v,
    this.products,
  });

  factory OrderSummaryModel.fromJson(Map<String, dynamic> json) => OrderSummaryModel(
    id: json["_id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    createdOn: json["createdOn"],
    tax: json["tax"].toDouble(),
    discount: json["discount"].toDouble(),
    subTotal: json["subTotal"].toDouble(),
    total: json["total"].toDouble(),
    status: json["status"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    v: json["__v"],
    products: json["products"] == null ? [] : List<ProductModel>.from(json["products"]!.map((x) => ProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user?.toJson(),
    "createdOn": createdOn,
    "tax": tax,
    "discount": discount,
    "subTotal": subTotal,
    "total": total,
    "status": status,
    "address": address?.toJson(),
    "__v": v,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Address {
  String? id;
  String? houseName;
  String? houseNo;
  String? firstLine;
  String? secondLine;
  String? city;
  String? state;
  String? country;
  String? pinCode;

  Address({
    this.id,
    this.houseName,
    this.houseNo,
    this.firstLine,
    this.secondLine,
    this.city,
    this.state,
    this.country,
    this.pinCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["_id"],
    houseName: json["house_name"],
    houseNo: json["house_no"],
    firstLine: json["first_line"],
    secondLine: json["second_line"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    pinCode: json["pin_code"],
  );

  Map<String, dynamic> toJson() => {
    "house_name": houseName,
    "house_no": houseNo,
    "first_line": firstLine,
    "second_line": secondLine,
    "city": city,
    "state": state,
    "country": country,
    "pin_code": pinCode,
  };
}


class User {
  String? id;
  String? firstName;
  String? lastName;

  User({
    this.id,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
  };
}
