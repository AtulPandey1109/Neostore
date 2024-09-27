import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/model/category_model/category_model.dart';
import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';

part 'category_events.dart';
part 'category_states.dart';

class CategoryBloc extends Bloc<CategoryEvent,CategoryState>{
  final Dio dio = Dio();
  final String url = '${AppConstants.baseurl}/category';
  CategoryBloc():super(CategoryInitialState(const [])){
    on<CategoryInitialEvent>(_onCategoryInitialEvent);
  }


  FutureOr<void> _onCategoryInitialEvent(CategoryInitialEvent event, Emitter<CategoryState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    try {
      Response response = await dio.get(url);
      if(response.data.length !=0){
        List<CategoryModel> categories =(response.data as List).map((category) => CategoryModel.fromJson(category))
            .toList();
        emit(CategoryInitialState(categories));
      }else{
        emit(CategoryInitialState(const []));
      }
    } catch (e) {
      emit(CategoryFailureState());
    }
  }
}