import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/view/widgets/app_custom_overlay_progress_indicator.dart';
import 'package:neostore/view/widgets/app_products_list.dart';
import 'package:neostore/viewmodel/product_bloc/all_products_cubit.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AllProductCubit>(context).initial();
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
      ),
      body: BlocConsumer<AllProductCubit, AllProductState>(
        builder: (context, state) {
          if (state is AllProductsInitialState) {
            return Stack(children: [
                    AppProductsList(
                      products: state.products,
                    ),
                    state.isLoading
                        ? const AppCustomOverlayProgressIndicator()
                        : const SizedBox.shrink()
                  ]);
          } else if (state is AllProductsEmptyState) {
            return const Center(
              child: Text('No product available'),
            );
          } else {
            return const Center(
              child: Text('Unable to load data'),
            );
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}
