import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/model/order_model/order_summary_model.dart';
import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';

part 'address_events.dart';
part 'address_states.dart';

class AddressBloc extends Bloc<AddressEvents,AddressState>{
  final Dio dio = Dio();
  final String url = '${AppConstants.baseurl}/address';
  AddressBloc():super(AddressInitialState(address: const [],)){
    on<AddressInitialEvent>(_onAddressInitialEvent);
    on<AddressAddEvent>(_onAddressAddEvent);
    on<AddressUpdateEvent>(_onAddressUpdateEvent);
    on<AddressDeleteEvent>(_onAddressDeleteEvent);
  }


  FutureOr<void> _onAddressInitialEvent(AddressInitialEvent event, Emitter<AddressState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    List<Address>? data = (state is AddressInitialState)?(state as AddressInitialState).address
        :null;
    emit(AddressInitialState(address: data??[],isLoading: true));
    try {
      Response response = await dio.get(url);
      List<Address> data = (response.data as List).map((address) => Address.fromJson(address))
          .toList();
      if(data.isNotEmpty){
      emit(AddressInitialState(address: data,isLoading: false));
      } else {
        emit(AddressEmptyState());
      }
    }on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(AddressTokenExpiredState());
      }
      else {
        emit(AddressFailureState());
      }
    }
  }

  FutureOr<void> _onAddressAddEvent(AddressAddEvent event, Emitter<AddressState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    List<Address>? data = (state is AddressInitialState)?(state as AddressInitialState).address
        :null;
    emit(AddressInitialState(address: data??[],isLoading: true));
    try {
      Response response = await dio.post(url,data: event.address.toJson());
      if(response.statusCode==201){
        emit(AddressAddedState());
        Response response = await dio.get(url);
        List<Address> data = (response.data as List).map((address) => Address.fromJson(address))
            .toList();
        if(data.isNotEmpty){
          emit(AddressInitialState(address: data,isLoading: false));
        } else {
          emit(AddressEmptyState());
        }
      }
    }on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(AddressTokenExpiredState());
      }
      else {
        emit(AddressFailureState());
      }
    } catch(e){
      emit(AddressFailureState());
    }
  }

  FutureOr<void> _onAddressUpdateEvent(AddressUpdateEvent event, Emitter<AddressState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    List<Address>? data = (state is AddressInitialState)?(state as AddressInitialState).address
        :null;
    emit(AddressInitialState(address: data??[],isLoading: true));
    try {

      Response response = await dio.patch('$url/${event.addressId}',data: event.address.toJson());
      if(response.statusCode==201|| response.statusCode==200){
        emit(AddressAddedState());
        Response response = await dio.get(url);
        List<Address> data = (response.data as List).map((address) => Address.fromJson(address))
            .toList();
        if(data.isNotEmpty){
          emit(AddressInitialState(address: data,isLoading: false));
        } else {
          emit(AddressEmptyState());
        }
      }
    }on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(AddressTokenExpiredState());
      }
      else {
        emit(AddressFailureState());
      }
    } catch(e){
      emit(AddressFailureState());
    }
  }

  FutureOr<void> _onAddressDeleteEvent(AddressDeleteEvent event, Emitter<AddressState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    List<Address>? data = (state is AddressInitialState)?(state as AddressInitialState).address
        :null;
    emit(AddressInitialState(address: data??[],isLoading: true));
    try {
      Response response = await dio.delete('$url/${event.addressId}');
      if(response.statusCode==201|| response.statusCode==200){
        emit(AddressAddedState());
        Response response = await dio.get(url);
        List<Address> data = (response.data as List).map((address) => Address.fromJson(address))
            .toList();
        if(data.isNotEmpty){
          emit(AddressInitialState(address: data,isLoading: false));
        } else {
          emit(AddressEmptyState());
        }
      }
    }on DioException catch (e) {
    if(e.response?.statusCode==401){
        emit(AddressTokenExpiredState());
      }
      else {
        emit(AddressFailureState());
      }
    } catch(e){
      emit(AddressFailureState());
    }
  }
}