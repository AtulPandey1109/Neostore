import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/order/model/order_model/order_summary_model.dart';

import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';

class ParticularOrderCubit extends Cubit<ParticularOrderState>{
  final Dio dio = Dio();
  final String url = '${AppConstants.baseurl}/orders';
  ParticularOrderCubit():super(ParticularOrderInitialState(false,null));

  void initial(String orderId) async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    emit(ParticularOrderInitialState(true,null));
    try {
      Response response = await dio.get('$url/$orderId');
      OrderSummaryModel order = OrderSummaryModel.fromJson(response.data);
        emit(ParticularOrderInitialState(false,order));

    } on DioException catch (e) {
      if(e.response?.statusCode==401){
        emit(ParticularOrderTokenExpiredState());
      }
      else {
        emit(ParticularOrderFailureState());
      }
    }catch (e) {
      emit(ParticularOrderFailureState());
    }
  }
}


abstract class ParticularOrderState extends Equatable{}

class ParticularOrderInitialState extends ParticularOrderState{
  final bool isLoading;
  final OrderSummaryModel? order;

  ParticularOrderInitialState(this.isLoading, this.order);
  @override
  List<Object?> get props => [isLoading,order];
}

class ParticularOrderEmptyState extends ParticularOrderState{
  @override
  List<Object?> get props => [];
}

class ParticularOrderFailureState extends ParticularOrderState{
  @override
  List<Object?> get props => [];
}

class ParticularOrderTokenExpiredState extends ParticularOrderState{
  @override
  List<Object?> get props => [];
}