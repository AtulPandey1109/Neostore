import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/view/splashscreen/splash_screen.dart';
import 'package:neostore/viewmodel/cart_bloc/cart_bloc.dart';
import 'package:neostore/viewmodel/category_bloc/category_bloc.dart';
import 'package:neostore/viewmodel/dashboard_bloc/dashboard_bloc.dart';
import 'package:neostore/viewmodel/login_bloc/login_bloc.dart';
import 'package:neostore/viewmodel/offer_bloc/offer_bloc.dart';
import 'package:neostore/viewmodel/order_bloc/order_bloc.dart';
import 'package:neostore/viewmodel/product_bloc/all_products_cubit.dart';
import 'package:neostore/viewmodel/product_bloc/product_bloc.dart';
import 'package:neostore/viewmodel/product_bloc/product_by_category_cubit.dart';
import 'package:neostore/viewmodel/profile_bloc/profile_bloc.dart';
import 'package:neostore/viewmodel/review_bloc/review_bloc.dart';
import 'package:neostore/viewmodel/search_bloc/search_bloc.dart';
import 'package:neostore/viewmodel/signup_bloc/sign_up_bloc.dart';
import 'package:neostore/viewmodel/subcategory/subcategory_bloc.dart';
import 'package:neostore/viewmodel/tab_navigation_bloc/tab_bloc.dart';
import 'package:neostore/viewmodel/wishlist_bloc/wishlist_bloc.dart';

import 'core/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => TabBloc()),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => OfferBloc()),
        BlocProvider(create: (context) => DashboardBloc()),
        BlocProvider(create: (context) => OrderBloc()),
        BlocProvider(create: (context) => SubcategoryBloc()),
        BlocProvider(create: (context) => SearchBloc()),
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => WishListBloc()),
        BlocProvider(create: (context) => ReviewBloc()),
        BlocProvider(create: (context) => ProductByCategoryCubit()),
        BlocProvider(create: (context) => AllProductCubit()),

      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textButtonTheme: const TextButtonThemeData(
              style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(Color(0xFFFF7643)))),
        ),
        debugShowCheckedModeBanner: false,
        title: 'NeoStore',
        home: const SplashScreen(),
        initialRoute: AppRoutes.initialScreen,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
