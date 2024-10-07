import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/view/widgets/app_products_list.dart';
import 'package:neostore/viewmodel/product_bloc/product_bloc.dart';
class AllProductsScreen extends StatefulWidget {
  final String? subCategoryId;
  const AllProductsScreen({super.key,required this.subCategoryId});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {

  @override
  void initState() {
    super.initState();
    widget.subCategoryId==null?
    BlocProvider.of<ProductBloc>(context).add(ProductGetAllEvent()):
    BlocProvider.of<ProductBloc>(context).add(ParticularCategoryProductEvent(widget.subCategoryId))
    ;
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
      body: BlocConsumer<ProductBloc,ProductState>(builder: (context, state) {
        if(state is ProductInitialState && state.isLoading){
          return const AppCustomCircularProgressIndicator(color: Colors.orange,);
        }
       else if(state is AllProductState){
          return state.isLoading?const AppCustomCircularProgressIndicator(color: Colors.orange,):AppProductsList(products: state.products,);
        }  else if(state is ParticularCategoryProductState){
         return state.isLoading?const AppCustomCircularProgressIndicator(color: Colors.orange,): AppProductsList(products: state.products);
        } else if (state is ProductEmptyState){
         return const Center(child: Text('No product available'),);
        }

       else {
          return const SizedBox.shrink();
        }
      }, listener: (context, state) {

      },),
    );
  }
}
