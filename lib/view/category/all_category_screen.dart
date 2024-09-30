import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/viewmodel/category_bloc/category_bloc.dart';
import 'package:neostore/viewmodel/subcategory/subcategory_bloc.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  ValueNotifier<String> selectedCategory =
      ValueNotifier('Popular Subcategories');
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryBloc>(context).add(CategoryInitialEvent());
    BlocProvider.of<SubcategoryBloc>(context).add(SubcategoryInitialEvent());
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
        title: const Text('All Categories'),
      ),
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            width: SizeConfig.screenWidth * 0.2,
            child: BlocConsumer<CategoryBloc, CategoryState>(
              builder: (BuildContext context, state) {
                if (state is CategoryInitialState && state.isLoading) {
                  return const AppCustomCircularProgressIndicator(
                    color: Colors.orange,
                  );
                } else if (state is CategoryInitialState && !state.isLoading) {
                  if (state.categories.isNotEmpty) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          final category = state.categories[index];
                          return GestureDetector(
                            onTap: () {
                              selectedCategory.value =
                                  category.name ?? '';
                              BlocProvider.of<SubcategoryBloc>(context).add(SubcategorySelectedEvent(id: category.id??''));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.network(
                                  category.image ?? '',
                                  height: 50,
                                  width: 50,
                                  errorBuilder: (context, error, stackTrace) =>
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
                        itemCount: state.categories.length);
                  } else {
                    return const AppCustomCircularProgressIndicator();
                  }
                } else {
                  return const AppCustomCircularProgressIndicator(
                      color: Colors.orange);
                }
              },
              listener: (BuildContext context, Object? state) {},
            ),
          ),
          Container(
            width: SizeConfig.screenWidth * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: kPaddingSide),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ValueListenableBuilder(
                  valueListenable: selectedCategory,
                  builder: (BuildContext context, value, Widget? child) {
                    return Text(
                      selectedCategory.value,
                      style: kHeader4TextStyle,
                    );
                  },
                ),
                BlocConsumer<SubcategoryBloc, SubcategoryState>(
                  builder: (context, state) {
                    if (state is SubcategoryFailureState) {
                      return const Text('Unable to load data');
                    } else if (state is SubcategoryInitialState &&
                        state.isLoading) {
                      return const AppCustomCircularProgressIndicator(
                        color: Colors.orange,
                      );
                    } else if (state is SubcategoryInitialState &&
                        !state.isLoading) {
                      return Expanded(
                        child: MasonryGridView.builder(
                          gridDelegate:
                              const SliverSimpleGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150),
                          itemCount: state.subcategories.length,
                          itemBuilder: (context, index) {
                            final subcategory = state.subcategories[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  FittedBox(
                                    child: CircleAvatar(
                                      radius:25,
                                      child: Container(
                                        constraints: BoxConstraints.tight(const Size(50, 50)),
                                        child: ClipRRect(
                                          borderRadius:BorderRadius.circular(25),
                                          child: Image.network(
                                            subcategory.image ?? '',
                                            fit: BoxFit.fill,
                                            errorBuilder: (context, error, stackTrace) =>
                                                Image.asset(
                                                    'assets/images/loading_image.webp'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(subcategory.name??'',)
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else if (state is SubcategoryParticularState &&
                        !state.isLoading) {
                      return Expanded(
                        child: MasonryGridView.builder(
                          gridDelegate:
                              const SliverSimpleGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 100),
                          itemCount: state.subcategories.length,
                          itemBuilder: (context, index) {
                            final subcategory = state.subcategories[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  FittedBox(
                                    child: CircleAvatar(
                                      radius:25,
                                      child: Container(
                                        constraints: BoxConstraints.tight(const Size(50, 50)),
                                        child: ClipRRect(
                                          borderRadius:BorderRadius.circular(25),
                                          child: Image.network(
                                            subcategory.image ?? '',
                                            fit: BoxFit.fill,
                                            errorBuilder: (context, error, stackTrace) =>
                                                Image.asset(
                                                    'assets/images/loading_image.webp'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(subcategory.name??'',textAlign: TextAlign.center,)
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else if(state is SubcategoryEmptyState){
                      return const Center(child: Text('Currently there is no subcategory'),);
                    }

                    else {
                      return const AppCustomCircularProgressIndicator(color: Colors.orange,);
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
