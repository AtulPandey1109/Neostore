import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:neostore/utils/app_generate_invoice.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/responsive_size_helper.dart';

import 'package:neostore/view/order/order_summary/particular_order_cubit.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';

import 'package:neostore/view/widgets/app_ordered_product_card.dart';
import 'package:neostore/view/widgets/app_rounded_button.dart';

class OrderSummaryScreen extends StatefulWidget {
  final String orderId;
  const OrderSummaryScreen({super.key, required this.orderId});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ParticularOrderCubit>(context).initial(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text('Order Summary'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: BlocBuilder<ParticularOrderCubit, ParticularOrderState>(
        builder: (context, state) {
          if (state is ParticularOrderInitialState) {
            if (state.isLoading) {
              return const AppCustomCircularProgressIndicator(
                color: Colors.orange,
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPaddingSide),
                child: SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: SizeConfig.isMobile()
                          ? SizeConfig.screenWidth
                          : SizeConfig.screenWidth * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: ListView.separated(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.order?.products?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final product = state.order?.products?[index];
                                    return AppOrderedProductCard(
                                      image: product?.image,
                                      name: product?.name,
                                      quantity: product?.quantity,
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Divider();
                                  },
                                ),
                              ),
                              const Divider(),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Ordered on: ',
                                      style: kHeader4TextStyle.copyWith(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      DateFormat('dd-MM-yyyy').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              state.order?.createdOn ?? 0)),
                                      style: kHeader4TextStyle,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Delivered To: ',
                                        style: kHeader4TextStyle.copyWith(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                          '${state.order?.user?.firstName} ${state.order?.user?.lastName}',
                                          style: kHeader4TextStyle),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: state.order?.address == null
                                          ? const SizedBox.shrink()
                                          : Text(
                                              '${state.order?.address?.houseNo}, ${state.order?.address?.firstLine}, ${state.order?.address?.secondLine}, ${state.order?.address?.city}, ${state.order?.address?.state}, ${state.order?.address?.country}, ${state.order?.address?.pinCode}',
                                              style: kHeader4TextStyle,
                                            ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12.0),
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'Price Details: ',
                                        style: kHeader4TextStyle.copyWith(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Sub Total: ',
                                          style: kHeader4TextStyle,
                                        ),
                                        Text(
                                          '${state.order?.subTotal} ',
                                          style: kHeader4TextStyle,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Discount price: ',
                                          style: kHeader4TextStyle,
                                        ),
                                        Text(
                                          '${state.order?.discount} ',
                                          style: kHeader4TextStyle,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Tax: ',
                                          style: kHeader4TextStyle,
                                        ),
                                        Text(
                                          '${state.order?.tax} ',
                                          style: kHeader4TextStyle,
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Total Price: ',
                                          style: kHeader4TextStyle,
                                        ),
                                        Text(
                                          '${state.order?.total} ',
                                          style: kHeader4TextStyle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                           AppRoundedElevatedButton(onPressed: () async{
                             generatePdf(order: state.order!);
                           }, label: const Text('Download pdf'),width: SizeConfig.screenWidth,)
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
