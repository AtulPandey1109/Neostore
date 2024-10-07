part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable{}

class ProfileInitialEvent extends ProfileEvent{
  @override
  List<Object?> get props => [];
}

class ProfileUpdateEvent extends ProfileEvent{
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNo;
  final String? gender;
  ProfileUpdateEvent(this.firstName, this.lastName, this.email, this.phoneNo, this.gender);

  @override
  List<Object?> get props => throw UnimplementedError();

}