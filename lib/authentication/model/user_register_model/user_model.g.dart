// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegisterModel _$UserRegisterModelFromJson(Map<String, dynamic> json) =>
    UserRegisterModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phone: json['phone'] as String?,
      gender: json['gender'] as String?,
    );

Map<String, dynamic> _$UserRegisterModelToJson(UserRegisterModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'gender': instance.gender,
    };
