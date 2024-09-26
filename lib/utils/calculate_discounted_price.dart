import 'package:neostore/model/offer_model/offer_model.dart';

double calculateDiscountedPrice(double productPrice, OfferModel? offer){
  double discountedPrice=0;
  if(offer==null){
    return productPrice;
  }else{
  if(offer.discountType=='percentage'){
    discountedPrice = productPrice-(productPrice*(offer.discountValue??0)/100);
  }
  }
  return discountedPrice;
}