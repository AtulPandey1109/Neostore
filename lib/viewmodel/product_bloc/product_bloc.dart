import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/model/product_model/product_model.dart';
import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';

part 'product_events.dart';
part 'product_states.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final Dio dio = Dio();
  final String url = '${AppConstants.baseurl}/products';
  ProductBloc() : super(ProductInitialState(product:null,isLoading: false)) {
    on<ProductInitialEvent>(onProductInitialEvent);
  }

  FutureOr<void> onProductInitialEvent(
      ProductInitialEvent event, Emitter<ProductState> emit) async {
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    emit(ProductInitialState(product:null,isLoading: true));
    try {
      Response response = await dio.get('$url/${event.productId}');
      ProductModel product = ProductModel.fromJson(response.data);
      emit(ProductInitialState(product: product,isLoading: false));
    } on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(TokenExpiredState());
      }
      else {
        emit(ProductFailureState());
      }
    }catch (e) {
      emit(ProductFailureState());
    }
  }

}
