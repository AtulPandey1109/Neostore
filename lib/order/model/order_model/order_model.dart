

import 'package:neostore/product/model/product_model/product_model.dart';

class OrderModel {
  String? id;
  String? user;
  int? createdOn;
  double? tax;
  double? discount;
  double? subTotal;
  double? total;
  String? status;
  String? address;
  int? v;
  List<ProductModel>? products;

  OrderModel({
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

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["_id"],
    user: json["user"],
    createdOn: json["createdOn"],
    tax: json["tax"].toDouble(),
    discount: json["discount"].toDouble(),
    subTotal: json["subTotal"].toDouble(),
    total: json["total"].toDouble(),
    status: json["status"],
    address: json["address"],
    v: json["__v"],
    products: json["products"] == null ? [] : List<ProductModel>.from(json["products"]!.map((x) => ProductModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "createdOn": createdOn,
    "tax": tax,
    "discount": discount,
    "subTotal": subTotal,
    "total": total,
    "status": status,
    "address": address,
    "__v": v,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}





