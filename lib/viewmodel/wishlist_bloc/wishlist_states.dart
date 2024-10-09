part of 'wishlist_bloc.dart';

abstract class WishListStates extends Equatable{}

class WishListInitialState extends WishListStates{
  final List<ProductModel>? products;
  final bool isLoading;

  WishListInitialState({this.products,this.isLoading=false});
  @override
  List<Object?> get props => [products];
}

class WishListEmptyState extends WishListStates{
  @override
  List<Object?> get props => [];
}

class WishListAddedSuccessFullyState extends WishListStates{
  @override
  List<Object?> get props =>[];
}

class WishListRemovedSuccessFullyState extends WishListStates{
  @override
  List<Object?> get props =>[];
}

class WishListFailureState extends WishListStates{
  @override
  List<Object?> get props => [];
}