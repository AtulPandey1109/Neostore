import 'package:flutter/material.dart';
import 'package:neostore/model/category_model/category_model.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel? category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  FittedBox(
            child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
              child: Container(
                constraints: BoxConstraints.tight(const Size(100, 100)),
                width: 200,
                height: 250,
                child: Image.network(
                  category?.image ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset('assets/images/loading_image.webp'),
                ),
              ),
            ),
          )

    );
  }
}
