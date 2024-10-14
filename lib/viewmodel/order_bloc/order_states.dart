part of 'order_bloc.dart';

abstract class OrderState extends Equatable{}

class OrderInitialState extends OrderState{
 final List<OrderModel> orders;
 final bool isLoading;
  OrderInitialState({required this.orders,this.isLoading=true});
  @override
  List<Object?> get props => [orders];
}

class OrderEmptyState extends OrderState{
  final bool isLoading;

  OrderEmptyState({this.isLoading = false});
  @override
  List<Object?> get props => [isLoading];
}
class OrderSuccessState extends OrderState{
  @override
  List<Object?> get props => [];
}
class OrderFailureState extends OrderState{
  final String? errorType;
  OrderFailureState({this.errorType});
  @override
  List<Object?> get props => [];
}

class OrderTokenExpiredState extends OrderState{
  @override
  List<Object?> get props => [];
}