import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/cart/model/cart_product_model/cart_product.dart';
import 'package:neostore/cart/viewmodel/cart_bloc/cart_bloc.dart';
import 'package:neostore/utils/responsive_size_helper.dart';


class CartTile extends StatelessWidget {
  final CartProduct cartProduct;
  const CartTile({super.key, required this.cartProduct});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: SizeConfig.screenWidth,
        child: Card(
            color: const Color(0xfff7f7f7),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Flexible(
                      flex: 3,
                      child: Image.network(
                        cartProduct.product?.image ?? '',
                        fit: BoxFit.contain,
                        height: 50,
                        width: 100,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset('assets/images/loading_image.webp'),
                      )),
                  Flexible(
                    flex: 9,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              maxLines: 1,
                              cartProduct.product?.name ?? '',
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 0.0, right: 6, top: 6, bottom: 6),
                                child: Text(
                                  'Rs. ${cartProduct.product?.price ?? 0}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Container(
                                height: 30,
                                decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    color: Colors.white),
                                child:
                                    Flex(direction: Axis.horizontal, children: [
                                  IconButton(
                                      onPressed: () {
                                        if ((cartProduct.quantity ?? 0) - 1 <=
                                            0) {
                                          BlocProvider.of<CartBloc>(context)
                                              .add(CartDeleteEvent(
                                                  productId:
                                                      cartProduct.product?.id ??
                                                          ''));
                                        } else {
                                          BlocProvider.of<CartBloc>(context)
                                              .add(CartUpdateEvent(
                                                  productId:
                                                      cartProduct.product?.id ??
                                                          '',
                                                  quantity: -1));
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                        color: Colors.orange,
                                        size: 16,
                                      )),
                                  Text('${cartProduct.quantity}'),
                                  IconButton(
                                      onPressed: () {
                                        BlocProvider.of<CartBloc>(context).add(
                                            CartUpdateEvent(
                                                productId:
                                                    cartProduct.product?.id ??
                                                        '',
                                                quantity: 1));
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.orange,
                                        size: 16,
                                      )),
                                ]),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title:
                                                  const Text('Delete product'),
                                              content: const Text(
                                                  'Are you sure you want to delete this product?'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('No')),
                                                TextButton(
                                                    onPressed: () {
                                                      BlocProvider.of<CartBloc>(
                                                              context)
                                                          .add(CartDeleteEvent(
                                                              productId: cartProduct.product?.id??''));
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Yes')),
                                              ],
                                            ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.orange,
                                    size: 16,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
/*

 leading: Image.network(cartProduct.product!.image!),
          title: Text(cartProduct.product!.name!),
          trailing: Text('${cartProduct.quantity}'),
          subtitle: Text('${cartProduct.product!.desc}'),
 */
