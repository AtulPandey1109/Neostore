import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: unused_import
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/view/widgets/app_wishlist_card.dart';
import 'package:neostore/viewmodel/wishlist_bloc/wishlist_bloc.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<WishListBloc>(context).add(WishListInitialEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text('My Wishlist'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingSide),
        child: BlocConsumer<WishListBloc,WishListStates>(
          builder: (BuildContext context, state) {
            if(state is WishListInitialState){
              if(state.isLoading){
                return const AppCustomCircularProgressIndicator(color: Colors.orange,);
              }
              else {
                return ListView.builder(
                  itemCount: state.products?.length??0,
                  itemBuilder: (context, index) {
                    final product = state.products?[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppWishlistCard(product:product),
                  );
                },);
              }
            }else if(state is WishListEmptyState){
              return const Center(child: Text('Wishlist is empty'),);
            }

           else{
             return const Center(child: Text('Unable to Load'),);
            }
          },
          listener: (BuildContext context, Object? state) {  },
        ),
      ),
    );
  }
}
