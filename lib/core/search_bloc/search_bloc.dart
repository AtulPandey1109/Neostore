import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/product/model/product_model/product_model.dart';

import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';

part 'search_state.dart';
part 'search_event.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final Dio dio = Dio();
  final String url = '${AppConstants.baseurl}/search/products';
  SearchBloc() : super(SearchInitialState(products: const [])) {
    on<SearchInitialEvent>(_onSearchInitialEvent);
    on<SearchResetEvent>(_onSearchResetEvent);
  }

  FutureOr<void> _onSearchInitialEvent(
      SearchInitialEvent event, Emitter<SearchState> emit) async {
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    emit(SearchInitialState(products: const[]));
    try {
      if((event.query?.length??0)>2){
        Response response = await dio.get('$url?productName=${event.query}');
        if(response.data.length !=0){
          List<ProductModel> products =(response.data as List).map((product) => ProductModel.fromJson(product))
              .toList();
          emit(SearchInitialState(products: products,isLoading: false));
        }
      }
      else{
        emit(SearchEmptyState());
      }
    } on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(TokenExpiredState());
      }
      else {
        emit(SearchEmptyState());
      }
    }catch (e) {
      emit(SearchEmptyState());
    }
  }

  FutureOr<void> _onSearchResetEvent(SearchResetEvent event, Emitter<SearchState> emit) {
    emit(SearchInitialState(products: const []));
  }
}
