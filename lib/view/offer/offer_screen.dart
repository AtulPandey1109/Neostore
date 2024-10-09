
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/view/widgets/app_rounded_offer_card.dart';
import 'package:neostore/viewmodel/offer_bloc/offer_bloc.dart';

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
          return const Center(child: AppCustomCircularProgressIndicator(color: Colors.orange,),);
        }
      },
      listener: (BuildContext context, Object? state) {  },
      ),
    );
  }
}
