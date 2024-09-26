import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/utils/app_local_storage.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/gridview_cross_axis_count.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/view/widgets/app_carousel_card.dart';
import 'package:neostore/view/widgets/app_category_list.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/view/widgets/app_product_card.dart';
import 'package:neostore/viewmodel/dashboard_bloc/dashboard_bloc.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DashboardBloc>(context).add(DashboardInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPaddingSide),
        child: SafeArea(
          child: BlocConsumer<DashboardBloc, DashboardState>(
            builder: (BuildContext context, state) {
              if (state is DashboardInitialState) {
                if (state.isLoading == true) {
                  return const AppCustomCircularProgressIndicator(
                    color: Colors.orange,
                  );
                } else {
                  return SizedBox(
                    height: SizeConfig.screenHeight,
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: AppCarouselCard(
                                    offers: state.data?.offers ?? [],
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Top categories'),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text('See all')),
                                ],
                              ),
                              SizedBox(
                                  height: 150,
                                  child: AppCategoryList(
                                      categories: state.data?.categories)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Popular Products'),
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text('View more')),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SliverMasonryGrid(
                          gridDelegate:
                              SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: myCrossAxisCount(),
                          ),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 20,
                          delegate: SliverChildBuilderDelegate(
                            childCount: state.data?.products?.length ?? 0,
                            (context, index) {
                              final product = state.data?.products?[index];
                              return AppProductCard(
                                productImageUrl: product?.image ?? '',
                                productName: product?.name ?? '',
                                price: product?.price ?? 0,
                                productId: product?.id??'',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return const Center(
                  child: AppCustomCircularProgressIndicator(),
                );
              }
            },
            listener: (BuildContext context, DashboardState state) {
              if (state is DashboardFailureState) {
                AppLocalStorage.removeToken();
                Navigator.pushNamedAndRemoveUntil(context,
                    AppRoutes.loginScreen, (Route<dynamic> route) => false);
              }
            },
          ),
        ),
      ),
    );
  }
}
