import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:neostore/cart/viewmodel/cart_bloc/cart_bloc.dart' as cart;
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/product/viewmodel/product_bloc/product_bloc.dart';
import 'package:neostore/review/viewmodel/review_bloc/review_bloc.dart';
import 'package:neostore/utils/app_local_storage.dart';
import 'package:neostore/utils/calculate_discounted_price.dart';
import 'package:neostore/utils/calculate_rating.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/widgets/app_rating_star.dart';
import 'package:neostore/widgets/app_rounded_button.dart';


class ProductScreen extends StatefulWidget {
  final String productId;
  const ProductScreen({super.key, required this.productId});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ValueNotifier<int> selectedOffer = ValueNotifier(0);
  final ValueNotifier<double> index = ValueNotifier(0);
  final TextEditingController _review = TextEditingController();
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
              // BlocProvider.of<ProductBloc>(context).add(ProductGetAllEvent());
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
                 
                  return Center(
                    child: SizedBox(
                      width: SizeConfig.isMobile()?SizeConfig.screenWidth:SizeConfig.screenWidth*0.7,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 7,
                            child: CustomScrollView(
                              controller: ScrollController(),
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
                                                  fontSize: 18),
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
                                              : product?.price??0;
                                          return Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  TweenAnimationBuilder(
                                                    tween: Tween<double>(begin: product?.price,end: discountedPrice),
                                                    duration: const Duration(milliseconds: 400),
                                                    builder: (BuildContext context, double value, Widget? child) {
                                                      return Text(
                                                        '₹${value.toStringAsFixed(2)}',
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 20,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  discountedPrice == product?.price
                                                      ? const SizedBox.shrink()
                                                      : Text(
                                                          '₹.${product?.price?.toStringAsFixed(2)}',
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
                                                        EdgeInsets.only(top: 12.0),
                                                    child: Text(
                                                      'Available Offers',
                                                      style: TextStyle(
                                                          fontSize: 18,
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
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  border: Border.all(
                                                                      color: selectedOffer
                                                                                  .value ==
                                                                              index
                                                                          ? Colors
                                                                              .green
                                                                          : Colors
                                                                              .transparent,
                                                                      width: 2.0)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(2.0),
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
                                          padding: const EdgeInsets.only(top: 16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Description',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                product?.desc ??
                                                    "100% Copper Cooling Coil Compatible with all BEE star rating AC's Compatibility: All Brands Non inverter ACs Compatible Refrigerant: R22 | R32 | R410A Brand's warranty: 12 months",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Reviews',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: SizedBox(
                                                        height: 300,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    const Text(
                                                                      'Rating: ',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              20),
                                                                    ),
                                                                    RatingBar.builder(
                                                                        initialRating:
                                                                            index
                                                                                .value,
                                                                        minRating: 1,
                                                                        direction: Axis
                                                                            .horizontal,
                                                                        allowHalfRating:
                                                                            true,
                                                                        itemCount: 5,
                                                                        itemSize: 24,
                                                                        itemBuilder:
                                                                            (context,
                                                                                    index) =>
                                                                                const Icon(
                                                                                  Icons.star,
                                                                                  color:
                                                                                      Color(0xffffc105),
                                                                                ),
                                                                        onRatingUpdate:
                                                                            (value) {
                                                                          index.value =
                                                                              value;
                                                                        })
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            Card(
                                                                child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: TextField(
                                                                controller: _review,
                                                                onTapOutside:
                                                                    (event) {
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                },
                                                                maxLines: 8, //or null
                                                                decoration:
                                                                    const InputDecoration
                                                                        .collapsed(
                                                                        hintText:
                                                                            "Add your comment here"),
                                                              ),
                                                            ))
                                                          ],
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            },
                                                            child:
                                                                const Text('Cancel')),
                                                        TextButton(
                                                            onPressed: () {
                                                              BlocProvider.of<
                                                                          ReviewBloc>(
                                                                      context)
                                                                  .add(AddReviewEvent(
                                                                      product?.id,
                                                                      index.value
                                                                          .toDouble(),
                                                                      _review.text));

                                                              _review.clear();
                                                              index.value=0;
                                                              BlocProvider.of<ProductBloc>(context)
                                                                  .add(ProductInitialEvent(productId: widget.productId));
                                                              Navigator.pop(context);
                                                            },
                                                            child: const Text('Ok'))
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              child: const Text(
                                                'Add review',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ],
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
                                                review?.user.firstName ?? '',
                                                style: const TextStyle(fontSize: 16),
                                              ),
                                              trailing: AppRatingStar(
                                                size: 14,
                                                rating:
                                                    review?.rating.toDouble() ?? 0,
                                              ),
                                              subtitle: Text(
                                                review?.comment ?? '',
                                                style: const TextStyle(fontSize: 14),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : const SliverToBoxAdapter(
                                        child: Text('No reviews available')),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40,
                            child: BlocConsumer<cart.CartBloc, cart.CartState>(
                              builder: (BuildContext context, state) {
                                if (state is cart.CartInitialState &&
                                    state.isLoading == true) {
                                  return AppRoundedElevatedButton(
                                    onPressed: () {},
                                    label:
                                        const AppCustomCircularProgressIndicator(),
                                    width: SizeConfig.screenWidth,
                                  );
                                } else {
                                  return AppRoundedElevatedButton(
                                    onPressed: () {
                                      if (product?.id != null) {
                                        BlocProvider.of<cart.CartBloc>(context).add(
                                            cart.CartAddEvent(productId: product?.id));
                                      }
                                    },
                                    label: const Text('Add to cart'),
                                    width: SizeConfig.screenWidth,
                                  );
                                }
                              },
                              listener: (BuildContext context, cart.CartState state) {
                                if (state is cart.CartAddedState) {
                                  BlocProvider.of<cart.CartBloc>(context).add(cart.CartInitialEvent());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Item added to the cart')));
                                }
                                if( state is cart.TokenExpiredState){
                                  AppLocalStorage.removeToken();
                                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreen,(Route<dynamic> route) => false);
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 10,)
                        ],
                      ),
                    ),
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
