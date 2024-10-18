part of 'review_bloc.dart';

abstract class ReviewEvent extends Equatable{}

class AddReviewEvent extends ReviewEvent{
  final String? productId;
  final double? rating;
  final String? comment;

  AddReviewEvent(this.productId, this.rating, this.comment);
  @override
  List<Object?> get props => [productId,rating,comment];
}