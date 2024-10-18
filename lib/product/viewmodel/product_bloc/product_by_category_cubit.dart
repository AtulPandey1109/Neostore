import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/product/model/product_model/product_model.dart';

import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';

class ProductByCategoryCubit extends Cubit<ProductByCategoryState>{
  final Dio dio = Dio();
  final String url = '${AppConstants.baseurl}/products';
  ProductByCategoryCubit():super(ProductByCategoryInitialState(false,const []));

  void initial(String subCategoryId) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    emit(ProductByCategoryInitialState(true,const []));
    try {
      Response response = await dio.get('$url?subCategory=$subCategoryId');
      List<ProductModel> products = (response.data as List).map((product)=>ProductModel.fromJson(product)).toList();
      if(products.isNotEmpty){
        emit(ProductByCategoryInitialState(false,products));
      } else{
        emit(ProductByCategoryEmptyState());
      }
    } on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(TokenExpiredState());
      }
      else {
        emit(ProductByCategoryFailureState());
      }
    }catch (e) {
      emit(ProductByCategoryFailureState());
    }
  }
  }


abstract class ProductByCategoryState extends Equatable{}

class ProductByCategoryInitialState extends ProductByCategoryState{
  final bool isLoading;
  final List<ProductModel>? products;

  ProductByCategoryInitialState(this.isLoading, this.products);
  @override
  List<Object?> get props => [isLoading,products];
}

class ProductByCategoryEmptyState extends ProductByCategoryState{
  @override
  List<Object?> get props => [];
}

class ProductByCategoryFailureState extends ProductByCategoryState{
  @override
  List<Object?> get props => [];
}

class TokenExpiredState extends ProductByCategoryState{
  @override
  List<Object?> get props => [];
}