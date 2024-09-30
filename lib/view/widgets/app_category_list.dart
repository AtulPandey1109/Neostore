import 'package:flutter/material.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/model/category_model/category_model.dart';
import 'package:neostore/view/widgets/category_card.dart';
class AppCategoryList extends StatelessWidget {
  final List<CategoryModel>? categories;
  const AppCategoryList({super.key, required this.categories});

  @override

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: categories?.length??0,
              itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, AppRoutes.allCategoryScreen,);
              },
              child: Column(
                children: [
                  CategoryCard(category: categories?[index],),
                ],
              ),
            );
          });
  }
}
