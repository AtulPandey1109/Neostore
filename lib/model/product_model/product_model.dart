import 'package:json_annotation/json_annotation.dart';
import 'package:neostore/model/category_model/category_model.dart';
import 'package:neostore/model/offer_model/offer_model.dart';
import 'package:neostore/model/review_model/review_model.dart';
import 'package:neostore/model/subcategory/subcategory_model.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  String? id;
  String? name;
  String? image;
  String? desc;
  double? price;
  CategoryModel? category;
  SubcategoryModel? subCategory;
  bool? isActive;
  List<OfferModel> offers;
  List<Review> reviews;
  bool? isWishList;

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
        this.reviews= const [],
        this.isWishList
      });

  factory ProductModel.fromJson( Map<String,dynamic> json) =>_$ProductModelFromJson(json);
  Map<String,dynamic> toJson()=>_$ProductModelToJson(this);
}
