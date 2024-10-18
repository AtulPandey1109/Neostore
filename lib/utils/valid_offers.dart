

import 'package:neostore/offer/model/offer_model/offer_model.dart';

List<OfferModel>? getValidOffers(String productCategory,List<OfferModel> offers ){
  List<OfferModel> applicableOffers =[];
  for(int i=0;i<offers.length;i++){
   final applicableCategories = offers[i].applicableCategories;
   if(applicableCategories !=null){
    if(applicableCategories.contains(productCategory)){
      applicableOffers.add(offers[i]);
    }
   }
    }
  if(applicableOffers.isEmpty) return null;
  return applicableOffers;
}