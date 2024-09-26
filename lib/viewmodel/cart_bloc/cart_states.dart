part of 'cart_bloc.dart';

abstract class CartState extends Equatable{}

class CartInitialState extends CartState{
  final List<CartProduct> cartProducts;
  final bool isLoading;
  CartInitialState({required this.cartProducts,required this.isLoading});
  @override
  List<Object?> get props => [cartProducts];
}

class CartFailureState extends CartState{
  @override
  List<Object?> get props => [];
}
class CartAddedState extends CartState{
  @override
  List<Object?> get props => [];
}