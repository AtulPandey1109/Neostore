import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/viewmodel/tab_navigation_bloc/tab_bloc.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<TabBloc,TabState>(
      builder: (BuildContext context, state) {
        return BottomNavigationBar(
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            currentIndex: state.tabIndex,
            onTap: (index){
             BlocProvider.of<TabBloc>(context).add(TabChangedEvent(index));
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'home',backgroundColor: Colors.white),
              BottomNavigationBarItem(icon: Icon(Icons.local_offer_outlined),label: 'offers',backgroundColor: Colors.white),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined),label: 'cart',backgroundColor: Colors.white),
              BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined),label: 'notifications',backgroundColor: Colors.white),

            ]);
      },
    );
  }
}
