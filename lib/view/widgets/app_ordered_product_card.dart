import 'package:flutter/material.dart';
import 'package:neostore/utils/constant_styles.dart';
class AppOrderedProductCard extends StatelessWidget {
  final String? image;
  final String? name;
  final int? quantity;
  const AppOrderedProductCard({super.key, this.image, this.name, this.quantity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: kPaddingSide),
      child: Row(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image.network(
              image ?? '',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/images/loading_image.webp',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product: ${name ?? ''}',style: kHeader4TextStyle,),
                  Text('Quantity: ${quantity ?? ''}'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
