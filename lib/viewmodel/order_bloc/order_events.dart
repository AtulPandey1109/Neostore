part of 'order_bloc.dart';



abstract class OrderEvent extends Equatable{}

class OrderInitialEvent extends OrderEvent{
  @override
  List<Object?> get props => [];
}

class OrderPlacedEvent extends OrderEvent{
  final String cartId;
  final String addressId;
  OrderPlacedEvent(this.cartId,this.addressId);
  @override
  List<Object?> get props => [cartId];
}