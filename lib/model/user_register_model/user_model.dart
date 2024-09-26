import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';


@JsonSerializable()
class UserRegisterModel {
  String? email;
  String? password;
  String? first_name;
  String? last_name;
  String? phone;
  String? gender;

  UserRegisterModel(
      {this.email,
        this.password,
        this.first_name,
        this.last_name,
        this.phone,
        this.gender});

  factory UserRegisterModel.fromJson( Map<String,dynamic> json) =>_$UserRegisterModelFromJson(json);
  Map<String,dynamic> toJson()=>_$UserRegisterModelToJson(this);
}
