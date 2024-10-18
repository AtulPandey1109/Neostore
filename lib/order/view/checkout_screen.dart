import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/address/viewmodel/address_bloc/address_bloc.dart';
import 'package:neostore/cart/model/cart_product_model/cart_product.dart';
import 'package:neostore/cart/viewmodel/cart_bloc/cart_bloc.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/order/model/order_model/order_summary_model.dart';
import 'package:neostore/order/viewmodel/order_bloc/order_bloc.dart';

import 'package:neostore/utils/app_local_storage.dart';

import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/widgets/app_rounded_button.dart';
import 'package:neostore/widgets/cart_tile.dart';


class CheckoutScreen extends StatefulWidget {
  final List<CartProduct> products;
  final String cartId;
  const CheckoutScreen(
      {super.key, required this.products, required this.cartId});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final ValueNotifier<Address> selectedAddress = ValueNotifier(Address());
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderBloc>(context).add(OrderInitialEvent());
    BlocProvider.of<AddressBloc>(context).add(AddressInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('Order Checkout'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: SizedBox(
              width: SizeConfig.isMobile()?SizeConfig.screenWidth:SizeConfig.screenWidth*0.7,
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
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kPaddingSide),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.addressScreen);
                                      },
                                      child: const Text('Add address'),
                                    )
                                  ],
                                ),
                              ),
                              ValueListenableBuilder(
                                builder: (context, value, child) {
                                  return BlocBuilder<AddressBloc, AddressState>(
                                    builder: (context, state) {
                                      if (state is AddressInitialState) {
                                        return ListView.builder(
                                          physics: const ClampingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: state.address.length,
                                          itemBuilder: (context, index) {
                                            final address = state.address[index];
                                            return RadioListTile(
                                              selected:
                                                  value == selectedAddress.value,
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text('${address.houseName}'),
                                                  IconButton(
                                                      iconSize: 20,
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            AppRoutes
                                                                .addressScreen,
                                                            arguments: {
                                                              "address": address
                                                            });
                                                      },
                                                      icon: const Icon(
                                                        Icons.edit,
                                                        color: Colors.orange,
                                                      ))
                                                ],
                                              ),
                                              subtitle: Text(
                                                  '${address.houseNo}, ${address.firstLine}, ${address.secondLine}, ${address.city}, ${address.state}, ${address.country}, ${address.pinCode}'),
                                              value: address,
                                              groupValue: selectedAddress.value,
                                              onChanged: (value) {
                                                selectedAddress.value = address;
                                              },
                                            );
                                          },
                                        );
                                      } else if (state is AddressEmptyState) {
                                        return const Center(
                                          child: Text(
                                              'Please add address in order to proceed'),
                                        );
                                      } else {
                                        return const SizedBox.shrink();
                                      }
                                    },
                                  );
                                },
                                valueListenable: selectedAddress,
                              )
                            ],
                          ),
                        ),
                        BlocConsumer<CartBloc, CartState>(
                          builder: (context, state) {
                            if (state is CartInitialState) {
                              return state.isLoading
                                  ? const SliverToBoxAdapter(
                                      child: AppCustomCircularProgressIndicator(
                                      color: Colors.orange,
                                    ))
                                  : SliverList.builder(
                                      itemCount: state.cartProducts.length,
                                      itemBuilder: (context, int index) {
                                        final product = state.cartProducts[index];
                                        return CartTile(cartProduct: product);
                                      });
                            } else {
                              return const SliverToBoxAdapter(
                                  child: AppCustomCircularProgressIndicator());
                            }
                          },
                          listener: (BuildContext context, CartState state) {
                            if (state is CartEmptyState) {
                              Navigator.pop(context);
                            }
                          },
                        ),
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
                            child: BlocBuilder<CartBloc, CartState>(
                              builder: (context, state) {
                                if (state is CartInitialState) {
                                  double total = calculateTotal(state.cartProducts);
                                  return state.isLoading
                                      ? const SizedBox.shrink()
                                      : Text('Rs. ${(total).toStringAsFixed(2)}',
                                          style: const TextStyle(
                                              color: Colors.orange,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700));
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
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
                                    BlocProvider.of<OrderBloc>(context).add(
                                        OrderPlacedEvent(widget.cartId,
                                            selectedAddress.value.id ?? ''));
                                  },
                                  label: !state.isLoading
                                      ? const Text('Confirm Order')
                                      : const AppCustomCircularProgressIndicator(),
                                  width: MediaQuery.sizeOf(context).width
                                      );
                            } else if (state is OrderEmptyState) {
                              return AppRoundedElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<OrderBloc>(context).add(
                                        OrderPlacedEvent(widget.cartId,
                                            selectedAddress.value.id ?? ''));
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
                            if (state is TokenExpiredState) {
                              AppLocalStorage.removeToken();
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  AppRoutes.loginScreen,
                                  (Route<dynamic> route) => false);
                            }
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
                            if (state is OrderFailureState) {
                              state.errorType == 'Invalid Address'
                                  ? ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Please select valid address')))
                                  : null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
