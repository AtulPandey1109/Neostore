part of 'category_bloc.dart';

abstract class CategoryState extends Equatable{}

class CategoryInitialState extends CategoryState{
  final List<CategoryModel> categories;
  final bool isLoading;
  CategoryInitialState({required this.categories, this.isLoading = false});
  @override
  List<Object?> get props => [categories];
}

class CategoryFailureState extends CategoryState{
  @override
  List<Object?> get props => [];
}

class CategoryTokenExpiredState extends CategoryState{
  @override
  List<Object?> get props => [];

}