part of 'login_bloc.dart';

abstract class LoginState extends Equatable{
  @override
  List<Object?> get props => [];
}

class InitialState extends LoginState {
  @override
  List<Object?> get props => [];
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

