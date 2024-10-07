import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/model/dashboard_model/dashboard_model.dart';
import 'package:neostore/utils/app_local_storage.dart';

import '../../utils/app_constants.dart';
part 'dashboard_events.dart';
part 'dashboard_states.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final Dio dio = Dio();
  final String url = '${AppConstants.baseurl}/dashboard';
  DashboardBloc() : super(DashboardInitialState(data: null,isLoading: false)) {
    on<DashboardInitialEvent>(onDashboardInitialEvent);
  }

  FutureOr<void> onDashboardInitialEvent(
      DashboardInitialEvent event, Emitter<DashboardState> emit) async {
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    DashBoardModel? data = (state is DashboardInitialState)?(state as DashboardInitialState).data
        :null;
    emit(DashboardInitialState(data: data,isLoading: true));
    try {
      Response response = await dio.get(url);
      DashBoardModel data = DashBoardModel.fromJson(response.data);
      emit(DashboardInitialState(data: data,isLoading: false));
    } catch (e) {
      emit(DashboardFailureState());
    }
  }
}