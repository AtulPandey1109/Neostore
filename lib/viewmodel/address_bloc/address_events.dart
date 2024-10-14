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

class AddressUpdateEvent extends AddressEvents{
  final Address address;
  final String addressId;
  AddressUpdateEvent(this.address, this.addressId);
  @override
  List<Object?> get props => [address,addressId];
}
class AddressDeleteEvent extends AddressEvents{
  final String addressId;
  AddressDeleteEvent(this.addressId);
  @override
  List<Object?> get props => [addressId];
}
