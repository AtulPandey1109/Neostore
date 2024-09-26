import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/utils/calculate_discounted_price.dart';
import 'package:neostore/utils/calculate_rating.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/view/widgets/app_rating_star.dart';
import 'package:neostore/view/widgets/app_rounded_button.dart';
import 'package:neostore/viewmodel/cart_bloc/cart_bloc.dart';
import 'package:neostore/viewmodel/product_bloc/product_bloc.dart';

class ProductScreen extends StatefulWidget {
  final String productId;
  const ProductScreen({super.key, required this.productId});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context)
        .add(ProductInitialEvent(productId: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingSide),
        child: BlocConsumer<ProductBloc, ProductState>(
          builder: (BuildContext context, state) {
            if (state is ProductInitialState) {
              if (state.isLoading) {
                return const Center(
                  child: AppCustomCircularProgressIndicator(
                    color: Colors.orange,
                  ),
                );
              } else {
                final product = state.product;
                final discountedPrice = product!=null?calculateDiscountedPrice(product.price??0, product.offers.isEmpty?null:product.offers[0]):product?.price;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: SizeConfig.screenHeight * .8,
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 300,
                                  child: Image.network(
                                    product?.image ?? '',
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        Image.asset(
                                            'assets/images/loading_image.webp'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        '${product?.name}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      )),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Row(children: [
                                    AppRatingStar(
                                      rating: calculateRating(
                                          product?.reviews ?? []),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '(${product?.reviews.length} Reviews)',
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Rs. ${discountedPrice?.toStringAsFixed(2)}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                       discountedPrice==product?.price?const SizedBox.shrink(): Text(
                                          'M.R.P Rs. ${product?.price}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      ],
                                    )),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Description',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(product?.desc ??
                                            "100% Copper Cooling Coil Compatible with all BEE star rating AC's Compatibility: All Brands Non inverter ACs Compatible Refrigerant: R22 | R32 | R410A Brand's warranty: 12 months"),
                                      ],
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      'Reviews',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SliverList(
                              delegate: SliverChildBuilderDelegate(
                            childCount: product?.reviews.length,
                            (context, index) {
                              final review = product?.reviews[index];
                              return ListTile(
                                title: Text(review?.user.firstName ?? ''),
                                trailing: AppRatingStar(
                                  rating: review?.rating.toDouble() ?? 0,
                                ),
                                subtitle: Text(review?.comment ?? ''),
                              );
                            },
                          ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: BlocConsumer<CartBloc, CartState>(
                        builder: (BuildContext context, state) {
                          return AppRoundedElevatedButton(
                            onPressed: () {
                              if (product?.id != null) {
                                BlocProvider.of<CartBloc>(context)
                                    .add(CartAddEvent(productId: product?.id));
                              }
                            },
                            label: const Text('Add to cart'),
                            width: SizeConfig.screenWidth,
                          );
                        },
                        listener: (BuildContext context, CartState state) {
                          if(state is CartAddedState){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item added to the cart')));
                          }
                        },
                      ),
                    )
                  ],
                );
              }
            } else {
              return const Center(
                child: AppCustomCircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            }
          },
          listener: (BuildContext context, Object? state) {},
        ),
      ),
    );
  }
}
