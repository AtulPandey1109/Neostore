import 'package:json_annotation/json_annotation.dart';
import 'package:neostore/model/category_model/category_model.dart';
import 'package:neostore/model/offer_model/offer_model.dart';
import 'package:neostore/model/product_model/product_model.dart';

part 'dashboard_model.g.dart';
@JsonSerializable()
class DashBoardModel {
  final List<CategoryModel>? categories;
  final List<OfferModel>? offers;
  final List<ProductModel>? products;

  DashBoardModel(
      {required this.categories, required this.offers, required this.products});

  factory DashBoardModel.fromJson(Map<String,dynamic> json)=> _$DashBoardModelFromJson(json);
  Map<String,dynamic> toJson() => _$DashBoardModelToJson(this);
}
