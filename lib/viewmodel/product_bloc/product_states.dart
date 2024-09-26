part of 'product_bloc.dart';



abstract class ProductState extends Equatable{}

class ProductInitialState extends ProductState{
  final bool isLoading;
  final ProductModel? product;

  ProductInitialState({required this.product,required this.isLoading});
  @override
  List<Object?> get props => [product];

}

class ProductFailureState extends ProductState{
  @override
  List<Object?> get props => [];
}