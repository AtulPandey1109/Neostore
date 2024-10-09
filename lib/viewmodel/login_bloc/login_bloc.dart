import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';

part 'login_events.dart';
part 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final dio = Dio();
  final String url = '${AppConstants.baseurl}/users/login';
  LoginBloc() : super(InitialState()) {
    on<InitialEvent>(onInitialEvent);
    on<LoginClickEvent>(onLoginClickEvent);
  }

  FutureOr<void> onLoginClickEvent(
      LoginClickEvent event, Emitter<LoginState> emit) async {
    emit(LoadingState());
    try {
      Response response = await dio.post(url, data: {
        "email": event.email.toLowerCase(),
        "password": event.password
      });
      if (response.statusCode == 200) {
        var data = response.data['token'];
        AppLocalStorage.saveToken(data);
        emit(LoginSuccessfulState(response: response));
      } else {

        emit(LoginFailureState(message: response.data['message']!));
      }
    } on DioException catch (e) {
      emit(LoginFailureState(message: e.response?.data['message']??''));
      emit(InitialState());
    }
  }

  FutureOr<void> onInitialEvent(
      InitialEvent event, Emitter<LoginState> emit) async {
    emit(InitialState());
  }
}
