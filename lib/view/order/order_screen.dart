import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/status_color.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/viewmodel/order_bloc/order_bloc.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order id: ${order.id ?? ''}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Status: ${order.status?.toLowerCase()}',
                              style: TextStyle(
                                  color: getStatusColor(order.status ?? '')),
                            ),
                            Text('Subtotal: ${order.subTotal}'),
                            Text('Delivered to: ${order.address?.firstLine??''}')
                          ],
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
        listener: (BuildContext context, OrderState state) {},
      ),
    );
  }
}
