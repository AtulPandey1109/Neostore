import 'package:flutter/material.dart';
class AppRatingStar extends StatelessWidget {
  final double rating;
  const AppRatingStar({super.key,this.rating=1});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: const Color(0xffffc105),
          size: 20,
        );
      }),
    );
  }
}
