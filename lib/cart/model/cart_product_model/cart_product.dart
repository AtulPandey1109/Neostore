import 'package:json_annotation/json_annotation.dart';
import 'package:neostore/product/model/product_model/product_model.dart';

part 'cart_product.g.dart';
@JsonSerializable()
class CartProduct {
  String? id;
  ProductModel? product;
  int? quantity;

  CartProduct({this.id, this.product, this.quantity});
  factory CartProduct.fromJson(Map<String,dynamic> json) => _$CartProductFromJson(json);
  Map<String,dynamic> toJson() => _$CartProductToJson(this);
}
