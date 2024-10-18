import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tab_events.dart';
part 'tab_states.dart';

class TabBloc extends Bloc<TabEvent,TabState>{
  TabBloc():super(const TabState(0)){
    on<TabChangedEvent>((event,emit){
      emit(TabState(event.tabIndex));
    });
  }
}