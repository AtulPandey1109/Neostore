import '../category_model/category_model.dart';

class SubcategoryModel {
  String? id;
  CategoryModel? category;
  String? name;
  String? image;

  SubcategoryModel({
    this.id,
    this.category,
    this.name,
    this.image,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) => SubcategoryModel(
    id: json["_id"],
    category: json["category"] == null ? null : CategoryModel.fromJson(json["category"]),
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "category": category?.toJson(),
    "name": name,
    "image": image,
  };
}
