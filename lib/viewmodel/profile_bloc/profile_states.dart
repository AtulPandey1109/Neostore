part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable{}

class ProfileInitialState extends ProfileState{
  final User? userDetail;
  final bool isLoading;
  ProfileInitialState({this.userDetail,this.isLoading=false});

  @override
  List<Object?> get props => [userDetail];
}

class ProfileFailureState extends ProfileState{
  @override
  List<Object?> get props => [];
}