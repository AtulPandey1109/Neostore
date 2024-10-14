part of 'address_bloc.dart';

abstract class AddressState extends Equatable{}

class AddressInitialState extends AddressState{
  final List<Address> address;
  final bool isLoading;
  AddressInitialState({required this.address, this.isLoading=false});
  @override
  List<Object?> get props => [address,isLoading];
}

class AddressFailureState extends AddressState{
  @override
  List<Object?> get props => [];
}
class AddressEmptyState extends AddressState{
  @override
  List<Object?> get props => [];
}
class AddressAddedState extends AddressState{
  @override
  List<Object?> get props => [];
}

class AddressTokenExpiredState extends AddressState{
  @override
  List<Object?> get props => [];
}