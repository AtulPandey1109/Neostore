part of 'wishlist_bloc.dart';

abstract class WishListEvents extends Equatable{}

class WishListInitialEvent extends WishListEvents{
  @override
  List<Object?> get props => [];
}

class WishListAddEvent extends WishListEvents{
  final String? productId;
  WishListAddEvent({this.productId});
  @override
  List<Object?> get props => [];
}

class WishListRemoveEvent extends WishListEvents{
  final String? productId;
  WishListRemoveEvent({this.productId});
  @override
  List<Object?> get props => [];
}