part of 'search_bloc.dart';

abstract class SearchState extends Equatable{}

class SearchInitialState extends SearchState{
  final List<ProductModel>? products;
  final bool isLoading;
  SearchInitialState({this.products, this.isLoading = true});
  @override
  List<Object?> get props => [products];

}

class SearchEmptyState extends SearchState{
  @override
  List<Object?> get props => [];

}

class TokenExpiredState extends SearchState{
  @override
  List<Object?> get props => [];
}