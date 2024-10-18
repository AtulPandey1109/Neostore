part of 'login_bloc.dart';

abstract class LoginState extends Equatable{
  @override
  List<Object?> get props => [];
}

class InitialState extends LoginState {
  final GoogleSignInSuccessState? googleSignInSuccessState;
  final FacebookSignInSuccessState? facebookSignInSuccessState;
  InitialState({this.googleSignInSuccessState,this.facebookSignInSuccessState});
  InitialState copyWith({GoogleSignInSuccessState? googleSignInSuccessState,FacebookSignInSuccessState? facebookSignInSuccessState}){
    return InitialState(googleSignInSuccessState:googleSignInSuccessState??this.googleSignInSuccessState,facebookSignInSuccessState: facebookSignInSuccessState??this.facebookSignInSuccessState);
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

class FacebookSignInSuccessState extends LoginState{
  final AuthCredential user;
  FacebookSignInSuccessState(this.user);
  FacebookSignInSuccessState copyWith(AuthCredential? user){
    return FacebookSignInSuccessState(user??this.user);
  }
}

