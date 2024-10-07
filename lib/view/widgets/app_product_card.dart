import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/viewmodel/wishlist_bloc/wishlist_bloc.dart';

class AppProductCard extends StatelessWidget {
  final String productId;
  final String? productImageUrl;
  final String? productName;
  final double? price;
  final bool? isWishList;
  const AppProductCard({
    super.key,
    required this.productImageUrl,
    required this.productName,
    required this.price,
    required this.productId,
    this.isWishList,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.productScreen,
            arguments: {"id": productId});
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
                productImageUrl ?? '',
                height: 100,
                width: 100,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/loading_image.webp');
                },
              ),
              Text(
                productName ?? 'error',
                style: const TextStyle(fontFamily: 'Poppins'),
                maxLines: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('₹$price'),
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<WishListBloc>(context)
                            .add(WishListAddEvent(productId: productId));
                      },
                      icon: isWishList ?? false
                          ? const Icon(
                              FontAwesomeIcons.solidHeart,
                              color: Color(0xffffc105),
                            )
                          : const Icon(FontAwesomeIcons.heart))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
