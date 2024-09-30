part of 'order_bloc.dart';



abstract class OrderEvent extends Equatable{}

class OrderInitialEvent extends OrderEvent{
  @override
  List<Object?> get props => [];
}

class OrderPlacedEvent extends OrderEvent{
  @override
  List<Object?> get props => [];
}