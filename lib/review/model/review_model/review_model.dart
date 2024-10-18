
import 'package:neostore/authentication/model/user_model/user_model.dart';

class Review {
  String id;
  String product;
  User user;
  double rating;
  String comment;
  DateTime createdAt;

  Review({
    required this.id,
    required this.product,
    required this.user,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["_id"],
    product: json["product"],
    user: User.fromJson(json["user"]),
    rating: json["rating"]?.toDouble(),
    comment: json["comment"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "product": product,
    "user": user.toJson(),
    "rating": rating,
    "comment": comment,
    "createdAt": createdAt.toIso8601String(),
  };
}