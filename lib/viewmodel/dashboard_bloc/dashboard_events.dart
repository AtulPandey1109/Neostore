part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {}

class DashboardInitialEvent extends DashboardEvent{
  @override
  List<Object?> get props => [];
}