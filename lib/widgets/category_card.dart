import 'package:flutter/material.dart';
import 'package:neostore/utils/constant_styles.dart';

class CategoryCard extends StatelessWidget {
  final String? image;
  final String? name;
  const CategoryCard({super.key, this.image, this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  Column(
        children: [
          ClipRRect(
                borderRadius: BorderRadius.circular(100),
            child: Container(

              width: 70,
              height: 70,
              constraints: BoxConstraints.tight(const Size(60, 60)),

              child: Image.network(
                image ?? '',
                fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/images/loading_image.webp');
                },
              ),
            ),
          ),
          Text(name??'',style: kHeader4TextStyle.copyWith(fontSize: 12),),
        ],
      )

    );
  }
}
