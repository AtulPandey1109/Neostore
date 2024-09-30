import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/model/cart_product_model/cart_product.dart';

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
    emit(CartInitialState(cartProducts: const [],isLoading: true));
    try {
      Response response = await dio.get(url);
      if(response.data.length !=0){
        List<CartProduct> cartProducts =(response.data['products'] as List).map((product) => CartProduct.fromJson(product))
            .toList();
        emit(CartInitialState(cartProducts: cartProducts,isLoading: false));
      }else{
        emit(CartEmptyState());
      }
    } catch (e) {
      emit(CartFailureState());
    }
  }

  FutureOr<void> _onCartDeleteEvent(CartDeleteEvent event, Emitter<CartState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    emit(CartInitialState(cartProducts: const [],isLoading: true));
    try{
      Response response = await dio.delete(url,data: {"product":event.productId});
      if(response.statusCode==200){
        Response response = await dio.get(url);
        if(response.data.length !=0){
          List<CartProduct> cartProducts =(response.data['products'] as List).map((product) => CartProduct.fromJson(product))
              .toList();
          emit(CartInitialState(cartProducts: cartProducts,isLoading: false));
        }
      }else{
        emit(CartInitialState(cartProducts: const [],isLoading: false));
      }
    } catch(e){
      emit(CartFailureState());
    }
  }

  FutureOr<void> _onCartUpdateEvent(CartUpdateEvent event, Emitter<CartState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    emit(CartInitialState(cartProducts: const [],isLoading: true));
    try{
      Response response = await dio.post(url,data: {"product":event.productId,"quantity":event.quantity});
      if(response.statusCode==200){
        Response response = await dio.get(url);
        if(response.data.length !=0){
          List<CartProduct> cartProducts =(response.data['products'] as List).map((product) => CartProduct.fromJson(product))
              .toList();
          emit(CartInitialState(cartProducts: cartProducts,isLoading: false));
        }
      }else{
        emit(CartInitialState(cartProducts: const [],isLoading: false));
      }
    } catch(e){
      emit(CartFailureState());
    }
  }

  FutureOr<void> _onCartAddEvent(CartAddEvent event, Emitter<CartState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    emit(CartInitialState(cartProducts: const [],isLoading: true));
    try{
      Response response = await dio.post(url,data: {"product":event.productId,"quantity":1});
      if(response.statusCode==200){
        emit(CartInitialState(cartProducts: const [],isLoading: false));
          emit(CartAddedState());

      }else{
        emit(CartFailureState());
      }
    } catch(e){
      emit(CartFailureState());
    }
  }
}