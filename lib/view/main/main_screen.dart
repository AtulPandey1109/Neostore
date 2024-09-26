import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/utils/app_local_storage.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/view/cart/cart_screen.dart';
import 'package:neostore/view/home/home_screen.dart';
import 'package:neostore/view/offer/offer_screen.dart';
import 'package:neostore/view/profile/profile_screen.dart';
import 'package:neostore/view/widgets/app_bottom_navigation_bar.dart';
import 'package:neostore/view/widgets/app_circular_icon.dart';
import 'package:neostore/view/widgets/app_drawer.dart';
import 'package:neostore/view/widgets/app_rounded_text_field.dart';
import 'package:neostore/viewmodel/tab_navigation_bloc/tab_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Widget> screen = [
    const HomeScreen(),
    const OfferScreen(),
    const CartScreen(),
    const ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: SizeConfig.isMobile()
                      ? MediaQuery.sizeOf(context).width * 0.8
                      : MediaQuery.sizeOf(context).width * 0.3,
                  child: AppRoundedTextField(
                    controller: _searchController,
                    icon: Icons.search,
                    labelText: 'Search your product',
                  )),
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: BlocBuilder<TabBloc, TabState>(
          builder: (BuildContext context, TabState state) {
            return screen[state.tabIndex];
          },
        ),
        bottomNavigationBar: const AppBottomNavigationBar(),
      ),
    );
  }
}
