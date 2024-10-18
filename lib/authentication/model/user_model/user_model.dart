class User {
  String? id;
  String? email;
  String? firstName;
  String? gender;
  String? lastName;
  String? phone;

  User({
    this.id,
    this.email,
    this.firstName,
    this.gender,
    this.lastName,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"]??'',
    email: json["email"]??'',
    firstName: json["first_name"]??'',
    gender: json["gender"]??'',
    lastName: json["last_name"]??'',
    phone: json["phone"]??'',
  );

  Map<String, dynamic> toJson() => {
    "_id": id??'',
    "email": email??'',
    "first_name": firstName??'',
    "gender": gender??'',
    "last_name": lastName??'',
    "phone": phone??'',
  };
}