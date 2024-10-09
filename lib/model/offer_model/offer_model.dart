import 'dart:convert';

OfferModel offerModelFromJson(String str) => OfferModel.fromJson(json.decode(str));

String offerModelToJson(OfferModel data) => json.encode(data.toJson());

class OfferModel {
  String? id;
  String? title;
  String? description;
  String? image;
  String? discountType;
  double? discountValue;
  List<dynamic>? applicableProducts;
  List<String>? applicableCategories;
  List<String>? applicableSubCategories;
  int? startDate;
  int? endDate;
  bool? isActive;
  int? maxUses;
  int? usedCount;

  OfferModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.discountType,
    required this.discountValue,
    required this.applicableProducts,
    required this.applicableCategories,
    required this.applicableSubCategories,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.maxUses,
    required this.usedCount,

  });

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    discountType: json["discountType"],
    discountValue:(json["discountValue"] as num?)?.toDouble(),
    applicableProducts: List<dynamic>.from(json["applicableProducts"].map((x) => x)),
    applicableCategories: List<String>.from(json["applicableCategories"].map((x) => x)),
    applicableSubCategories: List<String>.from(json["applicableSubCategories"].map((x) => x)),
    startDate: json["startDate"],
    endDate: json["endDate"],
    isActive: json["isActive"],
    maxUses: json["maxUses"],
    usedCount: json["usedCount"],

  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "image": image,
    "discountType": discountType,
    "discountValue": discountValue,
    "applicableProducts": List<dynamic>.from(applicableProducts!.map((x) => x)),
    "applicableCategories": List<dynamic>.from(applicableCategories!.map((x) => x)),
    "applicableSubCategories": List<dynamic>.from(applicableSubCategories!.map((x) => x)),
    "startDate": startDate,
    "endDate": endDate,
    "isActive": isActive,
    "maxUses": maxUses,
    "usedCount": usedCount,
  };
}
