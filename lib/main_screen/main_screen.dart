import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/core/search_bloc/search_bloc.dart';
import 'package:neostore/core/tab_navigation_bloc/tab_bloc.dart';
import 'package:neostore/dashboard/view/home_screen.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/cart/view/cart_screen.dart';

import 'package:neostore/notification/view/notification_screen.dart';
import 'package:neostore/offer/view/offer_screen.dart';
import 'package:neostore/widgets/app_bottom_navigation_bar.dart';
import 'package:neostore/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/widgets/app_drawer.dart';
import 'package:neostore/widgets/app_rounded_text_field.dart';


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
  void initState() {
    super.initState();
    BlocProvider.of<TabBloc>(context).add(TabChangedEvent(0));
  }
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
                      BlocProvider.of<SearchBloc>(context).add(SearchResetEvent());
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
            SizeConfig.isMobile()?const SizedBox.shrink():Row(
              children: [
               TextButton(onPressed: (){
                 BlocProvider.of<TabBloc>(context).add(TabChangedEvent(0));
               }, child: const Text('Home',style: TextStyle(fontSize: 18),)),
               TextButton(onPressed: (){
                 BlocProvider.of<TabBloc>(context).add(TabChangedEvent(1));
               }, child: const Text('Offers',style: TextStyle(fontSize: 18))),
               TextButton(onPressed: (){
                 BlocProvider.of<TabBloc>(context).add(TabChangedEvent(2));
               }, child: const Text('Cart',style: TextStyle(fontSize: 18))),
               TextButton(onPressed: (){
                 BlocProvider.of<TabBloc>(context).add(TabChangedEvent(3));
               }, child: const Text('Notifications',style: TextStyle(fontSize: 18))),
              ],
            ),
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
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 50,height:50,
                                        child: Image.network(product?.image??'',fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) {
                                          return Image.asset('assets/images/loading_image.webp');
                                        },),
                                      ),
                                      SizedBox(
                                          width: SizeConfig.screenWidth*0.75,
                                          child: Text(product?.name??'',)),
                                    ],
                                  ),
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
        bottomNavigationBar: SizeConfig.isMobile()?const AppBottomNavigationBar():null,
      ),
    );
  }
}
