import 'package:neostore/model/review_model/review_model.dart';

double calculateRating(List<Review> reviews) {
  int rating = 0;
  for (int i = 0; i < reviews.length; i++) {
    rating = rating + reviews[i].rating;
  }
  return rating / reviews.length;
}