// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegisterModel _$UserRegisterModelFromJson(Map<String, dynamic> json) =>
    UserRegisterModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      phone: json['phone'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$UserRegisterModelToJson(UserRegisterModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'phone': instance.phone,
      'gender': instance.gender,
    };
