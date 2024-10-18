import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/cart/model/cart_product_model/cart_product.dart';


import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';


part 'cart_events.dart';
part 'cart_states.dart';

class CartBloc extends Bloc<CartEvent,CartState>{
  final Dio dio = Dio();
  final String url = '${AppConstants.baseurl}/cart';
  CartBloc():super(CartInitialState(cartProducts: const [],isLoading: false)){
    on<CartInitialEvent>(_onCartInitialEvent);
    on<CartDeleteEvent>(_onCartDeleteEvent);
    on<CartUpdateEvent>(_onCartUpdateEvent);
    on<CartAddEvent>(_onCartAddEvent);
  }


  FutureOr<void> _onCartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    List<CartProduct> currentCartProducts = (state is CartInitialState)
        ? (state as CartInitialState).cartProducts
        : [];
    emit(CartInitialState(cartProducts: currentCartProducts,isLoading: false));
    try {
      Response response = await dio.get(url);
      if(response.data.length !=0){
        String cartId=response.data['_id'];
        List<CartProduct> cartProducts =(response.data['products'] as List).map((product) => CartProduct.fromJson(product))
            .toList();
        emit(CartInitialState(cartProducts: cartProducts,isLoading: false,cartId: cartId));
      }else{
        emit(CartEmptyState());
      }
    } on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(TokenExpiredState());
      }
      if(e.response?.statusCode==404){
        emit(CartEmptyState());
      }
      else {
        emit(CartFailureState());
      }
    }
  }

  FutureOr<void> _onCartDeleteEvent(CartDeleteEvent event, Emitter<CartState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    List<CartProduct> currentCartProducts = (state is CartInitialState)
        ? (state as CartInitialState).cartProducts
        : [];
    emit(CartInitialState(cartProducts: currentCartProducts,isLoading: true));
    try{
      Response response = await dio.delete(url,data: {"product":event.productId});
      if(response.statusCode==200){
        Response response = await dio.get(url);
        if(response.data.length !=0){
          String cartId=response.data['_id'];
          List<CartProduct> cartProducts =(response.data['products'] as List).map((product) => CartProduct.fromJson(product))
              .toList();
          emit(CartInitialState(cartProducts: cartProducts,isLoading: false,cartId: cartId));
        }else {
          emit(CartEmptyState());
        }
      }else{
        emit(CartEmptyState());
      }
    } on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(TokenExpiredState());
      }
      if(e.response?.statusCode==404){
        emit(CartEmptyState());
      }
      else {
        emit(CartFailureState());
      }
    }
  }

  FutureOr<void> _onCartUpdateEvent(CartUpdateEvent event, Emitter<CartState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    List<CartProduct> currentCartProducts = (state is CartInitialState)
        ? (state as CartInitialState).cartProducts
        : [];
    emit(CartInitialState(cartProducts: currentCartProducts,isLoading: true));
    try{

      Response response = await dio.post(url,data: {"product":event.productId,"quantity":event.quantity});
      if(response.statusCode==200){
        Response response = await dio.get(url);
        if(response.data.length !=0){
          List<CartProduct> cartProducts =(response.data['products'] as List).map((product) => CartProduct.fromJson(product))
              .toList();
          String cartId=response.data['_id'];
          emit(CartInitialState(cartProducts: cartProducts,isLoading: false,cartId: cartId));
        }
      }else{
        emit(CartInitialState(cartProducts: const [],isLoading: false));
      }
    } on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(TokenExpiredState());
      }
      if(e.response?.statusCode==404){
        emit(CartEmptyState());
      }
      else {
        emit(CartFailureState());
      }
    }
  }

  FutureOr<void> _onCartAddEvent(CartAddEvent event, Emitter<CartState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    List<CartProduct> currentCartProducts = (state is CartInitialState)
        ? (state as CartInitialState).cartProducts
        : [];
    emit(CartInitialState(cartProducts: currentCartProducts,isLoading: true));
    try{
      Response response = await dio.post(url,data: {"product":event.productId,"quantity":1});
      if(response.statusCode==200 || response.statusCode==201){
        emit(CartInitialState(cartProducts: const [],isLoading: false));
          emit(CartAddedState());

      }else{
        emit(CartFailureState());
      }
    } on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(TokenExpiredState());
      }
      if(e.response?.statusCode==404){
        emit(CartEmptyState());
      }
      else {
        emit(CartFailureState());
      }
    }
  }
}