
import 'package:neostore/review/model/review_model/review_model.dart';

double calculateRating(List<Review> reviews) {
  double rating = 0;
  if(reviews.isEmpty){
    return 0;
  }
  for (int i = 0; i < reviews.length; i++) {
    rating = rating + reviews[i].rating;
  }
  return rating / reviews.length;
}