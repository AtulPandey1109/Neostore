part of 'product_bloc.dart';



abstract class ProductState extends Equatable{}

class ProductInitialState extends ProductState{
  final bool isLoading;
  final ProductModel? product;

  ProductInitialState({required this.product,required this.isLoading});
  @override
  List<Object?> get props => [product];

}

class AllProductState extends ProductState{
  final bool isLoading;
  final List<ProductModel>? products;

  AllProductState({required this.products,required this.isLoading});
  @override
  List<Object?> get props => [products];

}

class ParticularCategoryProductState extends ProductState{
  final bool isLoading;
  final List<ProductModel>? products;

  ParticularCategoryProductState(this.isLoading, this.products);
  @override
  List<Object?> get props => [isLoading,products];
}

class ProductEmptyState extends ProductState{
  @override
  List<Object?> get props => [];
}

class ProductFailureState extends ProductState{
  @override
  List<Object?> get props => [];
}