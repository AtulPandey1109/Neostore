import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/product_category/model/subcategory/subcategory_model.dart';
import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';

part 'subcategory_events.dart';
part 'subcategory_states.dart';

class SubcategoryBloc extends Bloc<SubcategoryEvent, SubcategoryState> {
  final Dio dio = Dio();
  final String url = '${AppConstants.baseurl}/subCategory';
  SubcategoryBloc() : super(SubcategoryInitialState(subcategories: const [])) {
    on<SubcategoryInitialEvent>(_onSubcategoryInitialEvent);
    on<SubcategorySelectedEvent>(_onSubcategorySelectedEvent);
  }

  FutureOr<void> _onSubcategoryInitialEvent(
      SubcategoryInitialEvent event, Emitter<SubcategoryState> emit) async {
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    List<SubcategoryModel> subCategories =(state is SubcategoryInitialState)?(state as SubcategoryInitialState).subcategories:[];
    emit(SubcategoryInitialState(subcategories: subCategories, isLoading: true));
    try {
      Response response = await dio.get(url);
      if(response.data.length !=0){
        List<SubcategoryModel> subCategories =(response.data as List).map((subcategory) => SubcategoryModel.fromJson(subcategory))
            .toList();
        emit(SubcategoryInitialState(subcategories: subCategories,isLoading: false));
      }else{
        emit(SubcategoryEmptyState());
      }
    } on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(SubCategoryTokenExpiredState());
      }
      else {
        emit(SubcategoryFailureState());
      }
    }catch (e) {
      emit(SubcategoryFailureState());
    }
  }

  FutureOr<void> _onSubcategorySelectedEvent(SubcategorySelectedEvent event, Emitter<SubcategoryState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    List<SubcategoryModel> subCategories =(state is SubcategoryInitialState)?(state as SubcategoryInitialState).subcategories:[];
    emit(SubcategoryInitialState(subcategories: subCategories, isLoading: true));
    try {
      Response response = await dio.get('$url?category=${event.id}');
      if(response.data.length !=0){
        List<SubcategoryModel> subCategories =(response.data as List).map((subcategory) => SubcategoryModel.fromJson(subcategory))
            .toList();
        emit(SubcategoryParticularState(subcategories: subCategories));
      }else{
        emit(SubcategoryEmptyState());
      }
    } on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(SubCategoryTokenExpiredState());
      }
      else {
        emit(SubcategoryFailureState());
      }
    }catch (e) {
      emit(SubcategoryFailureState());
    }
  }
}

