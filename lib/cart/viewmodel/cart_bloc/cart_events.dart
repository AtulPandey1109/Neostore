part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable{}

class CartInitialEvent extends CartEvent{
  @override
  List<Object?> get props => [];
}

class CartDeleteEvent extends CartEvent{
  final String productId;
  CartDeleteEvent({required this.productId});

  @override
  List<Object?> get props => [];
}

class CartUpdateEvent extends CartEvent{
  final String productId;
  final int quantity;
  CartUpdateEvent({required this.productId, required this.quantity});
  @override
  List<Object?> get props => [productId,quantity];
}

class CartAddEvent extends CartEvent{
  final String? productId;

  CartAddEvent({required this.productId});

  @override
  List<Object?> get props =>[productId];
}

