part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class InitialEvent extends LoginEvent{
  @override
  List<Object?> get props => [];
}

class LoginClickEvent extends LoginEvent{
  final String email;
  final String password;
   LoginClickEvent({required this.email, required this.password});
}

class GoogleSignInEvent extends LoginEvent{
  @override
  List<Object?> get props => [];
}

class FacebookSignInEvent extends LoginEvent{
  @override
  List<Object?> get props => [];
}