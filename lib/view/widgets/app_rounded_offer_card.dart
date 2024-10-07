import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neostore/utils/responsive_size_helper.dart';

class AppRoundedOfferCard extends StatelessWidget {
  final String? image;
  final int? endDate;
  const AppRoundedOfferCard({super.key,this.image,this.endDate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        height: SizeConfig.screenHeight * 0.3,
        decoration: BoxDecoration(
            image: DecorationImage(
              opacity: 0.7,
              image: NetworkImage(image ?? ''),
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
                      color: Colors.redAccent),
                  child: Text(
                      'Ends on: ${DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(endDate ?? 0))}')),
            )),
      ),
    );
  }
}
