import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/model/user_model/user_model.dart';
import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';

part 'profile_events.dart';
part 'profile_states.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final Dio dio = Dio();
  final String url = '${AppConstants.baseurl}/profile';
  ProfileBloc() : super(ProfileInitialState(userDetail: null)) {
    on<ProfileInitialEvent>(_onProfileInitialEvent);
    on<ProfileUpdateEvent>(_onProfileUpdateEvent);
  }

  FutureOr<void> _onProfileInitialEvent(
      ProfileInitialEvent event, Emitter<ProfileState> emit) async {
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    User? user =(state is ProfileInitialState)?(state as ProfileInitialState).userDetail:null;
    emit(ProfileInitialState(userDetail: user, isLoading: true));
    try {
      Response response = await dio.get(url);
      if (response.data.length != 0) {
        User user = User.fromJson(response.data);
        emit(ProfileInitialState(userDetail: user, isLoading: false));
      } else {
        emit(ProfileInitialState());
      }
    } catch (e) {
      emit(ProfileFailureState());
    }
  }

  FutureOr<void> _onProfileUpdateEvent(
      ProfileUpdateEvent event, Emitter<ProfileState> emit) async {
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    User? user =(state is ProfileInitialState)?(state as ProfileInitialState).userDetail:null;
    emit(ProfileInitialState(userDetail: user, isLoading: true));
    try {
      Map<String, String?> data = {
        "first_name": event.firstName,
        "last_name": event.lastName,
        "email": event.email,
        "phone": event.phoneNo,
        "gender": event.gender
      };
      Response response = await dio.patch('${AppConstants.baseurl}/users',data: data);
      if(response.statusCode==200){
        User user = User.fromJson(response.data['user']);
        emit(ProfileInitialState(userDetail: user, isLoading: false));
      }
    } catch (e) {
      emit(ProfileFailureState());
    }
  }
}
