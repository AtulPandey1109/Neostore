import 'dart:io';

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
  final ValueNotifier<int> selectedOffer = ValueNotifier(0);
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context)
        .add(ProductInitialEvent(productId: widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPaddingSide),
          child: BlocConsumer<ProductBloc, ProductState>(
            builder: (BuildContext context, state) {
              if (state is ProductInitialState) {
                if (state.isLoading) {
                  return const AppCustomCircularProgressIndicator(
                    color: Colors.orange,
                  );
                } else {
                  final product = state.product;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: (Platform.isAndroid)
                            ? SizeConfig.screenHeight * .8
                            : SizeConfig.screenHeight * .75,
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
                                  ValueListenableBuilder(
                                    valueListenable: selectedOffer,
                                    builder: (BuildContext context, value,
                                        Widget? child) {
                                      final discountedPrice = product != null
                                          ? calculateDiscountedPrice(
                                              product.price ?? 0,
                                              product.offers.isEmpty
                                                  ? null
                                                  : product.offers[
                                                      selectedOffer.value])
                                          : product?.price;
                                      return Align(
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
                                              discountedPrice == product?.price
                                                  ? const SizedBox.shrink()
                                                  : Text(
                                                      'M.R.P Rs. ${product?.price}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 16,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                    ),
                                            ],
                                          ));
                                    },
                                  ),
                                  product?.offers.isNotEmpty ?? false
                                      ? Column(
                                          children: [
                                            const Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 8.0),
                                                child: Text(
                                                  'Available Offers',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 100,
                                              child: ValueListenableBuilder(
                                                valueListenable: selectedOffer,
                                                builder: (BuildContext context,
                                                    int value, Widget? child) {
                                                  return ListView.builder(
                                                    itemCount:
                                                        product?.offers.length,
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemBuilder:
                                                        (context, index) =>
                                                            GestureDetector(
                                                      onTap: () {
                                                        selectedOffer.value =
                                                            index;
                                                      },
                                                      child: SizedBox(
                                                        width: 200,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(20),
                                                            border: Border.all(color: selectedOffer.value==index?Colors.green:Colors.transparent,width: 2.0)

                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(2.0),
                                                            child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                child:
                                                                    Image.network(
                                                                  product
                                                                          ?.offers[
                                                                              index]
                                                                          .image ??
                                                                      '',
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        )
                                      : const SizedBox.shrink(),
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
                            product?.reviews.isNotEmpty ?? false
                                ? SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      childCount: product?.reviews.length,
                                      (context, index) {
                                        final review = product?.reviews[index];
                                        return ListTile(
                                          title: Text(
                                              review?.user.firstName ?? ''),
                                          trailing: AppRatingStar(
                                            rating:
                                                review?.rating.toDouble() ?? 0,
                                          ),
                                          subtitle: Text(review?.comment ?? ''),
                                        );
                                      },
                                    ),
                                  )
                                : const SliverToBoxAdapter(
                                    child: Text('No reviews available')),
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
                                  BlocProvider.of<CartBloc>(context).add(
                                      CartAddEvent(productId: product?.id));
                                }
                              },
                              label: const Text('Add to cart'),
                              width: SizeConfig.screenWidth,
                            );
                          },
                          listener: (BuildContext context, CartState state) {
                            if (state is CartAddedState) {
                              print('here');
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Item added to the cart')));
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
      ),
    );
  }
}
