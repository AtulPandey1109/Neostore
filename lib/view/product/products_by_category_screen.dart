import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/view/widgets/app_products_list.dart';
import 'package:neostore/viewmodel/product_bloc/product_by_category_cubit.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final String? subCategoryId;
  const ProductsByCategoryScreen({super.key, this.subCategoryId});

  @override
  State<ProductsByCategoryScreen> createState() => _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductByCategoryCubit>(context).initial(widget.subCategoryId??'');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:const Icon(Icons.arrow_back)),
      ),
      body: BlocConsumer<ProductByCategoryCubit,ProductByCategoryState>(builder: (context, state) {
        if(state is ProductByCategoryInitialState ){
         return state.isLoading?const AppCustomCircularProgressIndicator(color: Colors.orange,): AppProductsList(products: state.products,);
        }
        else if (state is ProductByCategoryEmptyState){
          return const Center(child: Text('No product available'),);
        }
        else {
          return const Center(child: Text('Unable to load data'),);
        }
      }, listener: (context, state) {

      },),
    );
  }
}
