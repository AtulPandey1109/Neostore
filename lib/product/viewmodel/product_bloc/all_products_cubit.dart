import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/model/product_model/product_model.dart';
import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';

class AllProductCubit extends Cubit<AllProductState> {
  final Dio dio = Dio();
  final String url = '${AppConstants.baseurl}/products';
  AllProductCubit() : super(AllProductsInitialState(false, const []));

  void initial() async {
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    List<ProductModel> products = (state is AllProductsInitialState)
        ? (state as AllProductsInitialState).products ?? []
        : const [];
    emit(AllProductsInitialState(true, products));
    try {
      Response response = await dio.get(url);
      List<ProductModel> products = (response.data as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();
      if (products.isNotEmpty) {
        emit(AllProductsInitialState(false, products));
      } else {
        emit(AllProductsEmptyState());
      }
    } on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(TokenExpiredState());
      }
      else {
        emit(AllProductsFailureState());
      }
    }catch (e) {
      emit(AllProductsFailureState());
    }
  }
}

abstract class AllProductState extends Equatable {}

class AllProductsInitialState extends AllProductState {
  final bool isLoading;
  final List<ProductModel>? products;

  AllProductsInitialState(this.isLoading, this.products);
  @override
  List<Object?> get props => [isLoading, products];
}

class AllProductsEmptyState extends AllProductState {
  @override
  List<Object?> get props => [];
}

class AllProductsFailureState extends AllProductState {
  @override
  List<Object?> get props => [];
}

class TokenExpiredState extends AllProductState{
  @override
  List<Object?> get props => [];
}