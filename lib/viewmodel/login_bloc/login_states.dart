part of 'login_bloc.dart';

abstract class LoginState extends Equatable{
  @override
  List<Object?> get props => [];
}

class InitialState extends LoginState {
  final GoogleSignInSuccessState? googleSignInSuccessState;
  InitialState({this.googleSignInSuccessState});
  InitialState copyWith({GoogleSignInSuccessState? googleSignInSuccessState}){
    return InitialState(googleSignInSuccessState:googleSignInSuccessState??this.googleSignInSuccessState);
  }
  @override
  List<Object?> get props => [googleSignInSuccessState];
}
class LoginSuccessfulState extends LoginState {
  final Response response;
  LoginSuccessfulState({required this.response});
  @override
  List<Object?> get props => [response];
}
class LoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginFailureState extends LoginState{
  final String message;
  @override
  List<Object?> get props => [message];
  LoginFailureState({required this.message});
}

class TokenExpiredState extends LoginState{
  @override
  List<Object?> get props => [];
}

class GoogleSignInSuccessState extends LoginState{
 final AuthCredential user;
  GoogleSignInSuccessState(this.user);
 GoogleSignInSuccessState copyWith(AuthCredential? user){
   return GoogleSignInSuccessState(user??this.user);
 }
 @override
 List<Object?> get props => [user];
}

