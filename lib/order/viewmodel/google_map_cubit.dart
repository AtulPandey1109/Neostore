import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:neostore/order/model/order_model/order_summary_model.dart';

class GoogleMapCubit extends Cubit<MapState>{
  GoogleMapCubit():super(MapInitialState());
 Future<void> initialEvent()async{
   emit(MapInitialState());
 }
  Future<void> changeAddress(Address address)async{
    try {
      String myAddress = "${address.firstLine??''},${address.secondLine??''},${address.city??''},${address.state??''}, ";
      List<Location> locations = await locationFromAddress(myAddress);
      if (locations.isNotEmpty) {
        final location = locations.first;
       emit(MapSuccessState(coordinates:  LatLng(location.latitude, location.longitude)));
      }
    } catch (e) {
      emit(MapFailureState(error: "Error fetching coordinates: $e"));
    }
  }

}


abstract class MapState extends Equatable{}

class MapInitialState extends MapState{
  @override
  List<Object?> get props => [];

}

class MapSuccessState extends MapState{
  final LatLng coordinates;
  MapSuccessState({required this.coordinates});
  @override
  List<Object?> get props => [coordinates];
}

class MapFailureState extends MapState{
  final String error;
  MapFailureState({required this.error});
  @override
  List<Object?> get props => [error];
}