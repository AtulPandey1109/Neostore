class User {
  String id;
  String firstName;
  String lastName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
  };
}