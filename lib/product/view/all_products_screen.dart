import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/product/viewmodel/product_bloc/all_products_cubit.dart';
import 'package:neostore/utils/app_local_storage.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/widgets/app_custom_overlay_progress_indicator.dart';
import 'package:neostore/widgets/app_products_list.dart';


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
        listener: (context, state) {
          if( state is TokenExpiredState){
            AppLocalStorage.removeToken();
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreen,(Route<dynamic> route) => false);
          }
        },
      ),
    );
  }
}
