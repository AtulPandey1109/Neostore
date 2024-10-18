part of 'sign_up_bloc.dart';

abstract class SignupEvent extends Equatable {}

class SignupInitialEvent extends SignupEvent {
  @override
  List<Object?> get props => [];
}

class SignupClickEvent extends SignupEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone;
  final String gender;

  SignupClickEvent(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.gender});
  @override
  List<Object?> get props => [email,password,firstName,lastName,phone,gender];
}
