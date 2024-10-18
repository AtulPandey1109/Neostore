

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neostore/utils/responsive_size_helper.dart';

class AppRoundedOfferCard extends StatelessWidget {
  final String? image;
  final int? endDate;
  const AppRoundedOfferCard({super.key,this.image,this.endDate});

  @override
  Widget build(BuildContext context) {
    String base64Image = image?.contains('data:image')??false?image?.split(',').last??'':'';
    var bytes = base64Decode(base64Image);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: SizeConfig.screenWidth*0.9,
        height: SizeConfig.screenHeight * 0.3,
        decoration: BoxDecoration(
            image: DecorationImage(
              opacity: 0.7,
              image: image?.contains('data:image')??false?MemoryImage(bytes):NetworkImage(image??''),
              fit: BoxFit.cover,
              onError: (exception, stackTrace) =>
                  Image.asset('assets/images/loading_image.webp'),
            ),
            borderRadius: BorderRadius.circular(10)),
        child: endDate == null?const SizedBox.shrink():Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: DateTime.now().compareTo(DateTime.fromMillisecondsSinceEpoch(endDate??0))==-1?Colors.green: Colors.redAccent),
                  child: Text(
                      'Ends on: ${DateFormat.yMd().format(DateTime.fromMillisecondsSinceEpoch(endDate??0))}')),
            )),
      ),
    );
  }
}
