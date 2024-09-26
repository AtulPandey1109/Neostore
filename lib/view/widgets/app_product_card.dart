import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neostore/core/routes/routes.dart';

class AppProductCard extends StatelessWidget {
  final String productId;
  final String? productImageUrl;
  final String? productName;
  final double? price;
  const AppProductCard({
    super.key,
    required this.productImageUrl,
    required this.productName,
    required this.price, required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.productScreen,arguments: {"id":productId}
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        elevation: 2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                productImageUrl??'' ,
                height: 100,
                width: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/loading_image.webp');
                },
              )
              ,
              Text(
                productName ?? 'error',
                style: const TextStyle(fontFamily: 'Poppins'),
                maxLines: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rs.$price'),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.heart))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
