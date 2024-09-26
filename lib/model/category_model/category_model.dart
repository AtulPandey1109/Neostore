
import 'package:json_annotation/json_annotation.dart';
part 'category_model.g.dart';
@JsonSerializable()
class CategoryModel{
  String? id;
  String? name;
  String? image;

  CategoryModel(
      this.id,
      this.name,
      this.image,
      );

  factory CategoryModel.fromJson( Map<String,dynamic> json) =>_$CategoryModelFromJson(json);
  Map<String,dynamic> toJson()=>_$CategoryModelToJson(this);
}