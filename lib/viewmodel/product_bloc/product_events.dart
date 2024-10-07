part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {}

class ProductInitialEvent extends ProductEvent{
  final String productId;

  ProductInitialEvent({required this.productId});
  @override
  List<Object?> get props => [productId];
}

class ParticularCategoryProductEvent extends ProductEvent{
  final String? subCategoryId;
  ParticularCategoryProductEvent(this.subCategoryId);
  @override
  List<Object?> get props => [subCategoryId];

}
class ProductGetAllEvent extends ProductEvent{
  @override
  List<Object?> get props => [];

}