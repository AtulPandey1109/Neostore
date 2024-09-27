class OrderModel {
  String? id;
  String? user;
  int? createdOn;
  List<Product>? products;
  int? tax;
  int? discount;
  double? subTotal;
  double? total;
  String? status;
  Address? address;
  int? v;

  OrderModel({
    this.id,
    this.user,
    this.createdOn,
    this.products,
    this.tax,
    this.discount,
    this.subTotal,
    this.total,
    this.status,
    this.address,
    this.v,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["_id"],
    user: json["user"],
    createdOn: json["createdOn"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    tax: json["tax"],
    discount: json["discount"],
    subTotal: json["subTotal"]?.toDouble(),
    total: json["total"]?.toDouble(),
    status: json["status"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user": user,
    "createdOn": createdOn,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "tax": tax,
    "discount": discount,
    "subTotal": subTotal,
    "total": total,
    "status": status,
    "address": address?.toJson(),
    "__v": v,
  };
}

class Address {
  String? firstLine;
  String? secondLine;
  String? city;
  String? state;
  String? country;
  String? pinCode;
  String? id;

  Address({
    this.firstLine,
    this.secondLine,
    this.city,
    this.state,
    this.country,
    this.pinCode,
    this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    firstLine: json["first_line"],
    secondLine: json["second_line"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    pinCode: json["pin_code"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "first_line": firstLine,
    "second_line": secondLine,
    "city": city,
    "state": state,
    "country": country,
    "pin_code": pinCode,
    "_id": id,
  };
}

class Product {
  String? product;
  int? quantity;
  String? id;

  Product({
    this.product,
    this.quantity,
    this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    product: json["product"],
    quantity: json["quantity"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "product": product,
    "quantity": quantity,
    "_id": id,
  };
}
