part of 'category_bloc.dart';

abstract class CategoryState extends Equatable{}

class CategoryInitialState extends CategoryState{
  final List<CategoryModel> categories;
  CategoryInitialState(this.categories);
  @override
  List<Object?> get props => [categories];
}

class CategoryFailureState extends CategoryState{
  @override
  List<Object?> get props => [];
}