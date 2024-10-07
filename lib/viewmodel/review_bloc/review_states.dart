part of 'review_bloc.dart';

abstract class ReviewState extends Equatable{}

class ReviewInitialState extends ReviewState{
  @override
  List<Object?> get props => [];
}

class ReviewAddedSuccessfullyState extends ReviewState{
  final bool isLoading;
  ReviewAddedSuccessfullyState({key,this.isLoading=false});
  @override
  List<Object?> get props => [];
}

class ReviewFailureState extends ReviewState{
  @override
  List<Object?> get props => [];
}