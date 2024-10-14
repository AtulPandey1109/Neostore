part of 'address_bloc.dart';

abstract class AddressEvents extends Equatable{}

class AddressInitialEvent extends AddressEvents{
  @override
  List<Object?> get props =>[];

}

class AddressAddEvent extends AddressEvents{
  final Address address;

  AddressAddEvent(this.address);
  @override
  List<Object?> get props => [address];

}