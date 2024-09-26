part of 'sign_up_bloc.dart';

abstract class SignupState extends Equatable{}

class SignUpInitialState extends SignupState{
  @override
  List<Object?> get props => [];
}

class SignUpLoadingState extends SignupState{
  @override
  List<Object?> get props => [];
}

class SignUpSuccessState extends SignupState{
  final String response;
  SignUpSuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class SignUpFailureState extends SignupState{
  final String message;
  SignUpFailureState({required this.message});
  @override
  List<Object?> get props => [message];
}