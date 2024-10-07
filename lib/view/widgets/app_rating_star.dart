import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AppRatingStar extends StatelessWidget {
  final double rating;
  final double size;
  const AppRatingStar({super.key, this.rating = 1, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: rating,
      ignoreGestures: true,
      allowHalfRating: true,
      itemSize: size,
      ratingWidget: RatingWidget(
          full: const Icon(
            Icons.star,
            color: Color(0xffffc105),
          ),
          half: const Icon(
            Icons.star_half,
            color: Color(0xffffc105),
          ),
          empty: const Icon(
            Icons.star_border,
            color: Color(0xffffc105),
          )),
      onRatingUpdate: (double value) {},
    );
  }
}
