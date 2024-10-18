import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:neostore/product/model/product_model/product_model.dart';

import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/gridview_cross_axis_count.dart';

import 'app_product_card.dart';

class AppProductsList extends StatelessWidget {
  final List<ProductModel>? products;
  const AppProductsList({super.key, this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: kPaddingSide, vertical: 8),
      child: CustomScrollView(
        slivers: [
          SliverMasonryGrid(
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: myCrossAxisCount(),
            ),
            mainAxisSpacing: 10,
            crossAxisSpacing: 20,
            delegate: SliverChildBuilderDelegate(
              childCount: products?.length ?? 0,
              (context, index) {
                final product = products?[index];
                return AppProductCard(
                  productImageUrl: product?.image ?? '',
                  productName: product?.name ?? '',
                  price: product?.price ?? 0,
                  productId: product?.id ?? '',
                  isWishList: product?.isWishList,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
