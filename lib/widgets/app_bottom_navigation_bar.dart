import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/viewmodel/cart_bloc/cart_bloc.dart';
import 'package:neostore/viewmodel/tab_navigation_bloc/tab_bloc.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({super.key});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(CartInitialEvent());
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(
      builder: (BuildContext context, state) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            currentIndex: state.tabIndex,
            onTap: (index) {
              BlocProvider.of<TabBloc>(context).add(TabChangedEvent(index));
            },
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'home',
                  backgroundColor: Colors.white),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.local_offer_outlined),
                  label: 'offers',
                  backgroundColor: Colors.white),
              BottomNavigationBarItem(
                  icon: BlocSelector<CartBloc,CartState,int>(
                    selector: (state ) {
                      if(state is CartInitialState && !state.isLoading){
                        return state.totalItems;
                      } else if(state is CartAddedState) {
                        return 1;
                      } else{
                        return 0;
                      }
                    },
                    builder: (context, state) {
                      return Stack(
                        children: [
                          const Icon(Icons.shopping_cart_outlined),
                          if (state > 0)
                            Positioned(
                              right: 0,
                              child: Container(
                                padding:const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),

                        ],
                      );
                    },
                  ),
                  label: 'cart',
                  backgroundColor: Colors.white),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_outlined),
                  label: 'notifications',
                  backgroundColor: Colors.white),
            ]);
      },
    );
  }
}
