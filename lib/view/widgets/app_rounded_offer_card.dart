import 'package:flutter/material.dart';
import 'package:neostore/model/offer_model/offer_model.dart';

class AppRoundedOfferCard extends StatelessWidget {
  final OfferModel offer;
  const AppRoundedOfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(offer.image ?? ''),
              fit: BoxFit.cover,
              onError: (exception, stackTrace) =>
                  Image.asset('assets/images/loading_image.webp'),
            ),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
