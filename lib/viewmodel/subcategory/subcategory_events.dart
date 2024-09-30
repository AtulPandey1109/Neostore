part of 'subcategory_bloc.dart';

abstract class SubcategoryEvent extends Equatable{}

class SubcategoryInitialEvent extends SubcategoryEvent{
  @override
  List<Object?> get props => [];
}
class SubcategorySelectedEvent extends SubcategoryEvent{
  final String id;
  SubcategorySelectedEvent({required this.id});
  @override
  List<Object?> get props =>[id];
}