import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/model/cart_product_model/cart_product.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/view/widgets/app_custom_overlay_progress_indicator.dart';
import 'package:neostore/view/widgets/app_rounded_button.dart';
import 'package:neostore/view/widgets/cart_tile.dart';
import 'package:neostore/viewmodel/cart_bloc/cart_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(CartInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
          builder: (BuildContext context, CartState state) {
        if (state is CartInitialState) {
          final total = calculateTotal(state.cartProducts);
          return Stack(children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: state.cartProducts.length,
                      itemBuilder: (context, int index) {
                        final cartProduct = state.cartProducts[index];
                        return CartTile(
                          cartProduct: cartProduct,
                        );
                      }),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16),
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
                      child: AppRoundedElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRoutes.orderSummaryScreen,arguments: {'data':state.cartProducts});
                          },
                          label: const Text('Buy Now'),
                          width: SizeConfig.isMobile()
                              ? MediaQuery.sizeOf(context).width
                              : MediaQuery.sizeOf(context).width * .3),
                    ),
                  ],
                )
              ],
            ),
            state.isLoading
                ? const AppCustomOverlayProgressIndicator()
                : const SizedBox.shrink()
          ]);
        } else if (state is CartEmptyState) {
          return const Center(
            child: Text('Your cart is empty'),
          );
        } else {
          return const AppCustomCircularProgressIndicator();
        }
      }),
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
