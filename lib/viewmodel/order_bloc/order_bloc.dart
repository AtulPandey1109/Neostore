import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/model/order_model/order_model.dart';
import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';
part 'order_events.dart';
part 'order_states.dart';

class OrderBloc extends Bloc<OrderEvent,OrderState>{
  final Dio dio = Dio();
  final String url = '${AppConstants.baseurl}/orders';
  OrderBloc():super(OrderInitialState(orders: const [],isLoading: false)){
    on<OrderInitialEvent>(_onOrderInitialEvent);
    on<OrderPlacedEvent>(_onOrderPlacedEvent);
  }


  FutureOr<void> _onOrderInitialEvent(OrderInitialEvent event, Emitter<OrderState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    emit(OrderInitialState(orders: const []));
    try {
      Response response = await dio.get(url);
      if(response.data.length !=0){
        List<OrderModel> orders =(response.data as List).map((order) => OrderModel.fromJson(order))
            .toList();
        emit(OrderInitialState(orders: orders,isLoading: false));
      }else{
        emit(OrderEmptyState());
      }
    } catch (e) {
      emit(OrderFailureState());
    }
  }

  FutureOr<void> _onOrderPlacedEvent(OrderPlacedEvent event, Emitter<OrderState> emit) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    emit(OrderInitialState(orders: const []));
    try{
      Response response = await dio.post(url,data: {
        "cartId": event.cartId,
        "address": {
          "hoouse_no" : "A06",
          "first_line": "Business Arcade Tower, 6th Floor",
          "second_line" : "Opp Parel Bus Depot, Sayani Road, Dadar",
          "city" : "Mumbai",
          "state" : "Maharashtra",
          "country" : "India",
          "pin_code" : "400014"
        }

      });
      if(response.statusCode==201){
        emit(OrderSuccessState());
      }
    }catch(e) {
      emit(OrderEmptyState());
    }
  }
}