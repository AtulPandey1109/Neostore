// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      desc: json['desc'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      category: json['category'] == null
          ? null
          : json['category'].runtimeType == String
              ? CategoryModel(json['category'], 'name', 'image')
              : CategoryModel.fromJson(
                  json['category'] as Map<String, dynamic>), //Needed to rewrite
      subCategory: json['subCategory'] == null
          ? null
          : json['subCategory'].runtimeType == String
              ? SubcategoryModel(
                  id: json['subCategory'],
                  category: CategoryModel(json['category'], 'name', 'image'),
                  name: 'name',
                  image: 'image')
              : SubcategoryModel.fromJson(json['subCategory']
                  as Map<String, dynamic>), //Needed to rewrite
      isActive: json['isActive'] as bool?,
      offers: (json['offers'] as List<dynamic>?)
              ?.map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      reviews: (json['reviews'] as List<dynamic>?)
              ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isWishList: json['isWishList'] as bool?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
      'desc': instance.desc,
      'price': instance.price,
      'category': instance.category,
      'subCategory': instance.subCategory,
      'isActive': instance.isActive,
      'offers': instance.offers,
      'reviews': instance.reviews,
      'isWishList': instance.isWishList
    };
