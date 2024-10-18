part of 'cart_bloc.dart';

abstract class CartState extends Equatable{}

class CartInitialState extends CartState{
  final String? cartId;
  final List<CartProduct> cartProducts;
  final bool isLoading;
  CartInitialState({required this.cartProducts,required this.isLoading,this.cartId});
  int get totalItems=> cartProducts.length;
  @override
  List<Object?> get props => [cartProducts,isLoading];
}

class CartFailureState extends CartState{
  @override
  List<Object?> get props => [];
}
class CartEmptyState extends CartState{
  @override
  List<Object?> get props => [];
}
class CartAddedState extends CartState{
  @override
  List<Object?> get props => [];
}

class TokenExpiredState extends CartState{
  @override
  List<Object?> get props => [];
}