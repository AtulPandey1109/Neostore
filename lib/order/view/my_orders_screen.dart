import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/utils/app_local_storage.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/status_color.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/viewmodel/order_bloc/order_bloc.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderBloc>(context).add(OrderInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.homeScreen,
                (route) => false,
              );
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text('My orders'),
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        builder: (BuildContext context, OrderState state) {
          if (state is OrderInitialState) {
            if (state.isLoading) {
              return const AppCustomCircularProgressIndicator(
                color: Colors.orange,
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: state.orders.length,
                  itemBuilder: (context, index) {
                    final order = state.orders[index];
                    return GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, AppRoutes.orderSummary, arguments: {"id": order.id} );
                      },
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: order.products?.length??0,
                                  itemBuilder: (context, index) {
                                    final product= order.products?[index];
                                 return Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Image.network(product?.image??'',height: 100,width: 100,errorBuilder: (context, error, stackTrace) {
                                     return Image.asset('assets/images/loading_image.webp');
                                   },),
                                 );
                                },),
                              ),
                              Text('No. of products: ${order.products?.length}',style: kHeader4TextStyle,),
                              Text(
                                'Status: ${order.status?.toLowerCase()}',
                                style: TextStyle(
                                    color: getStatusColor(order.status ?? '')),
                              ),
                              Text('Subtotal: ${order.subTotal}'),
                              Text('Ordered on: ${DateFormat('dd-MM-yyyy').format(DateTime.fromMillisecondsSinceEpoch(order.createdOn??0))}',style: kHeader4TextStyle.copyWith(fontWeight: FontWeight.w700),)
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          } else if (state is OrderEmptyState) {
            return const Center(
              child: Text('My order history is empty'),
            );
          } else {
            return const Text('Failed to load');
          }
        },
        listener: (BuildContext context, OrderState state) {
          if( state is OrderTokenExpiredState){
            AppLocalStorage.removeToken();
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreen,(Route<dynamic> route) => false);
          }
        },
      ),
    );
  }
}
