import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/product/model/product_model/product_model.dart';

import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';

part 'wishlist_events.dart';
part 'wishlist_states.dart';

class WishListBloc extends Bloc<WishListEvents, WishListStates> {
  final Dio dio = Dio();
  final String url = '${AppConstants.baseurl}/wishlist';
  WishListBloc() : super(WishListInitialState(products: null)) {
    on<WishListInitialEvent>(_onWishListInitialEvent);
    on<WishListAddEvent>(_onWishListAddEvent);
    on<WishListRemoveEvent>(_onWishListRemoveEvent);
  }

  FutureOr<void> _onWishListInitialEvent(
      WishListInitialEvent event, Emitter<WishListStates> emit) async {
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    List<ProductModel>? products =(state is WishListInitialState)?(state as WishListInitialState).products:null;
    emit(WishListInitialState(products: products, isLoading: true));
    try {
      Response response = await dio.get(url);
      if (response.data.length != 0) {
        List<ProductModel> products = (response.data as List)
            .map((product) => ProductModel.fromJson(product))
            .toList();
        emit(WishListInitialState(products: products, isLoading: false));
      } else {
        emit(WishListEmptyState());
      }
    } on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(TokenExpiredState());
      }
      else {
        emit(WishListFailureState());
      }
    }catch (e) {
      emit(WishListFailureState());
    }
  }

  FutureOr<void> _onWishListAddEvent(
      WishListAddEvent event, Emitter<WishListStates> emit) async {
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    List<ProductModel>? products =(state is WishListInitialState)?(state as WishListInitialState).products:null;
    emit(WishListInitialState(products: products, isLoading: true));
    try {
      Response response =
          await dio.post(url, data: {"product": event.productId});
      if (response.statusCode == 201) {
        emit(WishListAddedSuccessFullyState());
      }
    } on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(TokenExpiredState());
      }
      else {
        emit(WishListFailureState());
      }
    }catch (e) {
      emit(WishListFailureState());
    }
  }

  FutureOr<void> _onWishListRemoveEvent(
      WishListRemoveEvent event, Emitter<WishListStates> emit) async {
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    List<ProductModel>? products =(state is WishListInitialState)?(state as WishListInitialState).products:null;
    emit(WishListInitialState(products: products, isLoading: true));
    try {
      Response response =
          await dio.delete(url, data: {"product": event.productId});
      if (response.statusCode == 200) {
        emit(WishListRemovedSuccessFullyState());
        Response response = await dio.get(url);
        if (response.data.length != 0) {
          List<ProductModel> products = (response.data as List)
              .map((product) => ProductModel.fromJson(product))
              .toList();
          emit(WishListInitialState(products: products, isLoading: false));
        } else {
          emit(WishListEmptyState());
        }
      } else {
        emit(WishListEmptyState());
      }
    } on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(TokenExpiredState());
      }
      else {
        emit(WishListFailureState());
      }
    }catch (e) {
      emit(WishListFailureState());
    }
  }
}
