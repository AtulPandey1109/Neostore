import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';

part 'login_events.dart';
part 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final dio = Dio();
  final FirebaseAuth instance = FirebaseAuth.instance;
  final String url = '${AppConstants.baseurl}/users/login';
  LoginBloc() : super(InitialState()) {
    on<InitialEvent>(onInitialEvent);
    on<LoginClickEvent>(onLoginClickEvent);
    on<GoogleSignInEvent>(_onGoogleSignInEvent);
    on<FacebookSignInEvent>(_onFacebookSignInEvent);
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

      if(e.response?.statusCode==401){
        emit(TokenExpiredState());
      }
      emit(LoginFailureState(message: 'Incorrect email or password'));
      emit(InitialState());
    }
  }

  FutureOr<void> onInitialEvent(
      InitialEvent event, Emitter<LoginState> emit) async {
    emit(InitialState());
  }

  FutureOr<void> _onGoogleSignInEvent(GoogleSignInEvent event, Emitter<LoginState> emit) async {
    if(state is InitialState){
      final currentState = state as InitialState;
      try{
        final GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
        if (googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
          final AuthCredential authCredential = GoogleAuthProvider.credential(
              idToken: googleSignInAuthentication.idToken,
              accessToken: googleSignInAuthentication.accessToken);

          emit(currentState.copyWith(googleSignInSuccessState: GoogleSignInSuccessState(authCredential)));
        }

      } catch(e){
        emit(LoginFailureState(message: e.toString()));
      }
    }

  }

  FutureOr<void> _onFacebookSignInEvent(FacebookSignInEvent event, Emitter<LoginState> emit) async{
    if(state is InitialState){
      final currentState = state as InitialState;
      try {
        final LoginResult result = await FacebookAuth.instance.login();
        switch (result.status) {
          case LoginStatus.success:
            final AuthCredential facebookCredential =
            FacebookAuthProvider.credential(result.accessToken!.token);
            emit(currentState.copyWith(facebookSignInSuccessState: FacebookSignInSuccessState(facebookCredential)));
          case LoginStatus.cancelled:

          case LoginStatus.failed:

          default:
            return null;
        }
      } catch(e){
        emit(LoginFailureState(message: e.toString()));
      }
    }
  }
}
