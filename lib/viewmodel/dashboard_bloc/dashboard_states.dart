part of 'dashboard_bloc.dart';

abstract class DashboardState extends Equatable{}

class DashboardInitialState extends DashboardState{
  final DashBoardModel? data;
  final bool isLoading;

  DashboardInitialState({required this.data,required this.isLoading});
  @override
  List<Object?> get props => [data];

}

class DashboardFailureState extends DashboardState{
  final String? message;

  DashboardFailureState(this.message);
  @override
  List<Object?> get props =>[];

}