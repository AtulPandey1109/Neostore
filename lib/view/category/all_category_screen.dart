import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/view/widgets/category_card.dart';
import 'package:neostore/viewmodel/category_bloc/category_bloc.dart';
import 'package:neostore/viewmodel/subcategory/subcategory_bloc.dart';

class AllCategoryScreen extends StatefulWidget {
  final String? id;
  final String? name;
  const AllCategoryScreen({super.key, this.id, this.name});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  ValueNotifier<String> selectedCategory =
      ValueNotifier('Popular Subcategories');
  int crossAxisCount = 0;
  void getCrossAxisCount() {
    crossAxisCount = widget.id != null ? 3 : 2;
  }

  @override
  void initState() {
    super.initState();
    getCrossAxisCount();
    BlocProvider.of<CategoryBloc>(context).add(CategoryInitialEvent());
    widget.id == null
        ? BlocProvider.of<SubcategoryBloc>(context)
            .add(SubcategoryInitialEvent())
        : BlocProvider.of<SubcategoryBloc>(context)
            .add(SubcategorySelectedEvent(id: widget.id ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(widget.name ?? 'All Categories'),
      ),
      body: Row(
        children: [
          widget.id != null
              ? const SizedBox.shrink()
              : BlocConsumer<CategoryBloc,CategoryState>(
                builder: (BuildContext context, CategoryState state) {
                  if(state is CategoryInitialState){
                    return state.isLoading?const SizedBox.shrink():Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      width: SizeConfig.screenWidth * 0.2,
                      child: state.categories.isNotEmpty?ListView.separated(
                          itemBuilder: (context, index) {
                            final category = state.categories[index];
                            return GestureDetector(
                              onTap: () {
                                selectedCategory.value =
                                    category.name ?? '';
                                BlocProvider.of<SubcategoryBloc>(context)
                                    .add(SubcategorySelectedEvent(
                                    id: category.id ?? ''));
                              },
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Image.network(
                                    category.image ?? '',
                                    height: 50,
                                    width: 50,
                                    errorBuilder: (context, error,
                                        stackTrace) =>
                                        Image.asset(
                                            'assets/images/loading_image.webp'),
                                  ),
                                  Text(
                                    category.name ?? '',
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          itemCount: state.categories.length):const SizedBox.shrink(),
                    );
                  }
                  else {
                    return const AppCustomCircularProgressIndicator(
                        color: Colors.orange);
                  }
                }, listener: (BuildContext context, CategoryState state) {  },

              ),
          Container(
            width: widget.id == null
                ? SizeConfig.screenWidth * 0.8
                : SizeConfig.screenWidth,
            padding: const EdgeInsets.symmetric(horizontal: kPaddingSide),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.name == null
                    ? Center(
                        child: ValueListenableBuilder(
                          valueListenable: selectedCategory,
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return Text(
                              selectedCategory.value,
                              style: kHeader4TextStyle,
                            );
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
                BlocConsumer<SubcategoryBloc, SubcategoryState>(
                  builder: (context, state) {
                    if (state is SubcategoryFailureState) {
                      return const Text('Unable to load data');
                    } else if (state is SubcategoryInitialState &&
                        state.isLoading) {
                      return const Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppCustomCircularProgressIndicator(
                              color: Colors.orange,
                            ),
                          ],
                        ),
                      );
                    } else if (state is SubcategoryInitialState &&
                        !state.isLoading) {
                      return Expanded(
                          child: GridView.builder(
                        itemCount: state.subcategories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: 1.5),
                        itemBuilder: (context, index) {
                          final subcategory = state.subcategories[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.particularProductsScreen,
                                  arguments: {'subCategoryId': subcategory.id});
                            },
                            child: CategoryCard(
                              image: subcategory.image,
                              name: subcategory.name,
                            ),
                          );
                        },
                      ));
                    } else if (state is SubcategoryParticularState &&
                        !state.isLoading) {
                      return SizedBox(
                          height: 150,
                          child: GridView.builder(
                            itemCount: state.subcategories.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    childAspectRatio: 1.2),
                            itemBuilder: (context, index) {
                              final subcategory = state.subcategories[index];
                              return GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(
                                      context, AppRoutes.particularProductsScreen,
                                      arguments: {'subCategoryId': subcategory.id});
                                },
                                child: CategoryCard(
                                  image: subcategory.image,
                                  name: subcategory.name,
                                ),
                              );
                            },
                          ));
                    } else if (state is SubcategoryEmptyState) {
                      return const Center(
                        child: Text('Currently there is no subcategory'),
                      );
                    } else {
                      return const AppCustomCircularProgressIndicator(
                        color: Colors.orange,
                      );
                    }
                  },
                  listener: (context, state) {},
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
