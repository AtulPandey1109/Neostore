import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';

part 'review_events.dart';
part 'review_states.dart';

class ReviewBloc extends Bloc<ReviewEvent,ReviewState>{
  final Dio dio =Dio();
  final String url = '${AppConstants.baseurl}/review';
  ReviewBloc():super(ReviewInitialState()){
    on<AddReviewEvent>(_onAddReviewEvent);
  }

  FutureOr<void> _onAddReviewEvent(AddReviewEvent event, Emitter<ReviewState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    emit(ReviewAddedSuccessfullyState(isLoading: true));
    try{
      Response response = await dio.post(url,data:{"product":event.productId,"rating":event.rating,"comment":event.comment} );
      if(response.statusCode==201){
        emit(ReviewAddedSuccessfullyState(isLoading: false));
      }
    } on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(TokenExpiredState());
      }
      else {
        emit(ReviewFailureState());
      }
    }catch(e){
      emit(ReviewFailureState());
    }
  }
}