part of 'subcategory_bloc.dart';

abstract class SubcategoryState extends Equatable{}

class SubcategoryInitialState extends SubcategoryState{
  final List<SubcategoryModel> subcategories;
  final bool isLoading;

  SubcategoryInitialState({required this.subcategories,this.isLoading=false});
  @override
  List<Object?> get props => [subcategories];

}
class SubcategoryParticularState extends SubcategoryState{
  final List<SubcategoryModel> subcategories;
  final bool isLoading;

  SubcategoryParticularState({required this.subcategories,this.isLoading=false});
  @override
  List<Object?> get props => [subcategories];

}

class SubcategoryEmptyState extends SubcategoryState{
  @override
  List<Object?> get props => [];

}

class SubcategoryFailureState extends SubcategoryState{
  @override
  List<Object?> get props => [];
}