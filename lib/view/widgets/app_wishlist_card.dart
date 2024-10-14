import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neostore/model/product_model/product_model.dart';
import 'package:neostore/utils/constant_styles.dart';
// ignore: unused_import
import 'package:neostore/view/widgets/app_rating_star.dart';
import 'package:neostore/viewmodel/cart_bloc/cart_bloc.dart';
import 'package:neostore/viewmodel/wishlist_bloc/wishlist_bloc.dart';

class AppWishlistCard extends StatelessWidget {
  final ProductModel? product;
  const AppWishlistCard({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: const BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: Colors.orange))),
      padding: const EdgeInsets.symmetric(horizontal: kPaddingSide),
      child: Row(
        children: [
          Flexible(
            flex: 3,
            child: SizedBox(
              height: 70,
              width: 70,
              child: Image.network(
                product?.image ?? '',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  'assets/images/loading_image.webp',
                ),
              ),
            ),
          ),
          Flexible(
            flex: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product: ${product?.name ?? ''}'),
                      Text(
                        'Description: ${product?.desc ?? ''}',
                        maxLines: 2,
                      ),
                      Text('Price: ₹${product?.price ?? ''}'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          BlocProvider.of<WishListBloc>(context).add(
                              WishListRemoveEvent(
                                  productId: product?.id ?? ''));
                        },
                        icon: const Icon(FontAwesomeIcons.solidHeart),
                        color: Colors.orange,
                      ),
                      TextButton(
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context)
                                .add(CartAddEvent(productId: product?.id));
                            BlocProvider.of<WishListBloc>(context).add(
                                WishListRemoveEvent(
                                    productId: product?.id ?? ''));
                          },
                          child: const Text('Add to Cart')),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
