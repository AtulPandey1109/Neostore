import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/model/offer_model/offer_model.dart';
import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';

part 'offer_events.dart';
part 'offer_states.dart';

class OfferBloc extends Bloc<OfferEvent, OfferState> {
  final Dio dio = Dio();
  final String url = '${AppConstants.baseurl}/offer';
  OfferBloc() : super(OfferInitialState(offers: const [])) {
    on<OfferInitialEvent>(_onOfferInitialEvent);
  }

  FutureOr<void> _onOfferInitialEvent(
      OfferInitialEvent event, Emitter<OfferState> emit) async {
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    try {
      Response response = await dio.get(url);
      if (response.data.length != 0) {
        List<OfferModel> offers = (response.data as List)
            .map((offer) => OfferModel.fromJson(offer))
            .toList();
        emit(OfferInitialState(offers: offers));
      } else {
        emit(OfferInitialState(offers: const []));
      }
    }on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(TokenExpiredState());
      }
      else {
        emit(OfferFailureState());
      }
    }
  }
}
