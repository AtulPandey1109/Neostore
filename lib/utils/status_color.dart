import 'package:flutter/material.dart';

Color getStatusColor(String status){
  if(status=='COMPLETED'){
    return Colors.green;
  } else if(status == 'PENDING'){
    return Colors.orangeAccent;
  } else{
    return Colors.red;
  }
}