part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable{}

class SearchInitialEvent extends SearchEvent{
  final String? query;
  SearchInitialEvent(this.query);
  @override
  List<Object?> get props => [query];

}