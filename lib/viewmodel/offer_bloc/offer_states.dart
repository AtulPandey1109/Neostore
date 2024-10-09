part of 'offer_bloc.dart';

abstract class OfferState extends Equatable{}

class OfferInitialState extends OfferState{
  final List<OfferModel> offers;

  OfferInitialState({required this.offers});
  @override
  List<Object?> get props => [offers];
}

class OfferFailureState extends OfferState{
  @override
  List<Object?> get props =>[];
}

class TokenExpiredState extends OfferState{
  @override
  List<Object?> get props => [];
}