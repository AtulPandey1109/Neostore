
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/offer/viewmodel/offer_bloc/offer_bloc.dart';
import 'package:neostore/utils/app_local_storage.dart';
import 'package:neostore/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/widgets/app_rounded_offer_card.dart';


class OfferScreen extends StatefulWidget {
  const OfferScreen({super.key});

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OfferBloc>(context).add(OfferInitialEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OfferBloc,OfferState>(builder: (BuildContext context, state) {
        if(state is OfferInitialState){
        return ListView.builder(
          itemCount: state.offers.length,
          itemBuilder: (context, index){
            final offer = state.offers[index];
          return AppRoundedOfferCard(image: offer.image,endDate: offer.endDate,);
        },);
        }
        else{
          return const AppCustomCircularProgressIndicator(color: Colors.orange,);
        }
      },
      listener: (BuildContext context, Object? state) {
        if( state is TokenExpiredState){
          AppLocalStorage.removeToken();
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreen,(Route<dynamic> route) => false);
        }
      },
      ),
    );
  }
}
