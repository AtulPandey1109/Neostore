import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/model/user_register_model/user_model.dart';
import 'package:neostore/utils/app_constants.dart';

part 'sign_up_events.dart';
part 'sign_up_states.dart';

class SignUpBloc extends Bloc<SignupEvent,SignupState>{
  final dio = Dio();
  final String url = '${AppConstants.baseurl}/users/signup';
  SignUpBloc():super(SignUpInitialState()){
    on<SignupInitialEvent>(onSignupInitialEvent);
    on<SignupClickEvent>(onSignupClickEvent);
  }


  FutureOr<void> onSignupClickEvent(SignupClickEvent event, Emitter<SignupState> emit) async{
    emit(SignUpLoadingState());
    try{
      var data =UserRegisterModel(email: event.email,password: event.password,firstName: event.firstName,lastName: event.lastName,phone: event.phone,gender: event.gender).toJson();
      Response response = await dio.post(url,
          data: data);
      if(response.statusCode==201){
        emit(SignUpSuccessState(response: 'Account created successfully'));
      } else {
        emit(SignUpFailureState(message: 'Account creation failed'));
      }
    } catch(e) {
      emit(SignUpFailureState(message: 'Error Occurred'));
      emit(SignUpInitialState());
    }

  }

  FutureOr<void> onSignupInitialEvent(SignupInitialEvent event, Emitter<SignupState> emit) async{
    emit(SignUpInitialState());
  }
}