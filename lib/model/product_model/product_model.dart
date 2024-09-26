import 'package:json_annotation/json_annotation.dart';
import 'package:neostore/model/offer_model/offer_model.dart';
import 'package:neostore/model/review_model/review_model.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  String? id;
  String? name;
  String? image;
  String? desc;
  double? price;
  String? category;
  String? subCategory;
  bool? isActive;
  List<OfferModel> offers;
  List<Review> reviews;

  ProductModel(
      {this.id,
        this.name,
        this.image,
        this.desc,
        this.price,
        this.category,
        this.subCategory,
        this.isActive,
        this.offers=const [],
        this.reviews= const []
      });

  factory ProductModel.fromJson( Map<String,dynamic> json) =>_$ProductModelFromJson(json);
  Map<String,dynamic> toJson()=>_$ProductModelToJson(this);
}
