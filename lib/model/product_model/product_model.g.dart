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
      category: json['category'] as String?,
      subCategory: json['subCategory'] as String?,
      isActive: json['isActive'] as bool?,
      offers: (json['offers'] as List<dynamic>?)
          ?.map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
          .toList()??[],
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList()??[],
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'desc': instance.desc,
      'price': instance.price,
      'category': instance.category,
      'subCategory': instance.subCategory,
      'isActive': instance.isActive,
      'offers': instance.offers,
      'reviews': instance.reviews,
    };
