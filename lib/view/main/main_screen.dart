import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/view/cart/cart_screen.dart';
import 'package:neostore/view/home/home_screen.dart';
import 'package:neostore/view/notification/notification_screen.dart';
import 'package:neostore/view/offer/offer_screen.dart';
import 'package:neostore/view/widgets/app_bottom_navigation_bar.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/view/widgets/app_drawer.dart';
import 'package:neostore/view/widgets/app_rounded_text_field.dart';
import 'package:neostore/viewmodel/search_bloc/search_bloc.dart';
import 'package:neostore/viewmodel/tab_navigation_bloc/tab_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _searchController = TextEditingController();

  final ValueNotifier<bool> searchVisible = ValueNotifier(false);

  final List<Widget> screen = [
    const HomeScreen(),
    const OfferScreen(),
    const CartScreen(),
    const NotificationScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) {
              return ValueListenableBuilder(
                valueListenable: searchVisible,
                builder: (BuildContext context, value, Widget? child) {
                  if(searchVisible.value){
                   return IconButton(onPressed: (){
                      searchVisible.value=false;
                    }, icon: const Icon(Icons.arrow_back));
                  } else{
                    return IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  }
                },
              );
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                child: SizedBox(
                    width: SizeConfig.isMobile()
                        ? MediaQuery.sizeOf(context).width * 0.85
                        : MediaQuery.sizeOf(context).width * 0.3,
                    child: AppRoundedTextField(
                      controller: _searchController,
                      icon: Icons.search,
                      labelText: 'Search your product',
                      onChange: (val){
                        if(val.length>2){
                          BlocProvider.of<SearchBloc>(context).add(SearchInitialEvent(val));
                        }
                      },
                      onTap: () {
                        searchVisible.value = true;
                      },
                      onTapOutside:(event){
                        _searchController.clear();
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    )),
              ),
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: Stack(
          children: [
            BlocBuilder<TabBloc, TabState>(
              builder: (BuildContext context, TabState state) {
                return screen[state.tabIndex];
              },
            ),
            ValueListenableBuilder(
              valueListenable: searchVisible,
              builder: (BuildContext context, bool value, Widget? child) {
                return Visibility(
                  visible: searchVisible.value,
                  child: Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight,
                    color: Colors.white,
                    child: BlocBuilder<SearchBloc, SearchState>(
                      builder: (BuildContext context, state) {
                        if (state is SearchInitialState ) {
                          return state.isLoading? const AppCustomCircularProgressIndicator(
                            color: Colors.orange,
                          ):ListView.builder(
                            itemCount: state.products?.length??0,
                            itemBuilder: (context, index) {
                              final product = state.products?[index];
                              return  GestureDetector(
                                onTap: (){
                                  Navigator.pushNamed(context, AppRoutes.productScreen,arguments: {"id":product?.id??''}
                                  );
                                },
                                child: ListTile(
                                  tileColor: Colors.black,
                                  title: Text(product?.name??''),
                                ),
                              );
                            },
                          );
                        } else if(state is SearchEmptyState){
                          return const Center(child: Text('No result found'),);
                        } else{
                          return const SizedBox.shrink();
                        }

                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: const AppBottomNavigationBar(),
      ),
    );
  }
}
