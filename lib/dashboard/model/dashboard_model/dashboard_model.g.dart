// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashBoardModel _$DashBoardModelFromJson(Map<String, dynamic> json) =>
    DashBoardModel(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      offers: (json['offers'] as List<dynamic>?)
          ?.map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['popular_products'] as List<dynamic>?)
          ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashBoardModelToJson(DashBoardModel instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'offers': instance.offers,
      'products': instance.products,
    };
