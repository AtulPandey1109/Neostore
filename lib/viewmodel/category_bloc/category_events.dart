part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable{}

class CategoryInitialEvent extends CategoryEvent{
  @override
  List<Object?> get props => [];
}