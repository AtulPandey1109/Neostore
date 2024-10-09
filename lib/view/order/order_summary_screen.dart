import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/model/cart_product_model/cart_product.dart';

import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/view/widgets/app_rounded_button.dart';
import 'package:neostore/view/widgets/cart_tile.dart';
import 'package:neostore/viewmodel/order_bloc/order_bloc.dart';

class OrderSummaryScreen extends StatefulWidget {
  final List<CartProduct> products;
  final String cartId;
  const OrderSummaryScreen(
      {super.key, required this.products, required this.cartId});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  final ValueNotifier<int> addressIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final total = calculateTotal(widget.products);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Order Summary'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.isMobile()
                  ? Platform.isIOS
                      ? SizeConfig.screenHeight * 0.7
                      : SizeConfig.screenHeight * 0.75
                  : SizeConfig.screenHeight,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 250,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPaddingSide),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Deliver to:'),
                                TextButton(
                                  style: ButtonStyle(
                                      shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      side: const WidgetStatePropertyAll(
                                          BorderSide(
                                              width: 1.0,
                                              color: Colors.orange))),
                                  onPressed: () {},
                                  child: const Text('Add address'),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: ValueListenableBuilder(
                              builder:(context, value, child) {
                                return ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                      selected: value==addressIndex.value,
                                      title: const Text(
                                          'A06, Business Arcade Tower, 6th Floor,Opp Parel Bus Depot, Sayani Road, Dadar'),
                                      subtitle: const Text('Mumbai, Maharashtra, India, 400014'),
                                      value: index,
                                      groupValue: addressIndex.value,
                                      onChanged: (value) {
                                        addressIndex.value = index;
                                      },
                                    );
                                  },
                                );
                              }, valueListenable: addressIndex ,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverList.builder(
                      itemCount: widget.products.length,
                      itemBuilder: (context, int index) {
                        final product = widget.products[index];
                        return CartTile(cartProduct: product);
                      }),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                      child: Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16),
                      child: Text('Rs. ${(total).toStringAsFixed(2)}',
                          style: const TextStyle(
                              color: Colors.orange,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocConsumer<OrderBloc, OrderState>(
                    builder: (context, state) {
                      if (state is OrderInitialState) {
                        return AppRoundedElevatedButton(
                            onPressed: () {
                              BlocProvider.of<OrderBloc>(context)
                                  .add(OrderPlacedEvent(widget.cartId));
                            },
                            label: !state.isLoading
                                ? const Text('Confirm Order')
                                : const AppCustomCircularProgressIndicator(),
                            width: SizeConfig.isMobile()
                                ? MediaQuery.sizeOf(context).width
                                : MediaQuery.sizeOf(context).width * .3);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                    listener: (BuildContext context, Object? state) {
                      if (state is OrderSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Order placed successfully')));
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.myOrdersScreen,
                          (route) => true,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

double calculateTotal(List<CartProduct> product) {
  double total = 0;
  for (int i = 0; i < product.length; i++) {
    total = total + (product[i].product!.price! * product[i].quantity!);
  }
  return total;
}
