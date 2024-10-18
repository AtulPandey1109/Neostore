part of 'tab_bloc.dart';

abstract class TabEvent extends Equatable{}

class TabChangedEvent extends TabEvent{
  final int tabIndex;

  TabChangedEvent(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];

}