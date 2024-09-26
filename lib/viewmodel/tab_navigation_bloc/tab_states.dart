part of 'tab_bloc.dart';

class TabState extends Equatable{
  final int tabIndex;
  const TabState(this.tabIndex);
  @override
  List<Object?> get props => [tabIndex];
}
