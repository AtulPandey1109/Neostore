import 'package:flutter/material.dart';
import 'package:neostore/main.dart';
import 'package:neostore/view/login/login_screen.dart';
import 'package:neostore/view/main/main_screen.dart';
import 'package:neostore/view/order/order_screen.dart';
import 'package:neostore/view/product/product_screen.dart';
import 'package:neostore/view/sign_up/sign_up_screen.dart';
import 'package:neostore/view/splashscreen/splash_screen.dart';






class AppRoutes{
  static const String initialScreen='/';
  static const String loginScreen='/loginScreen';
  static const String homeScreen='/homeScreen';
  static const String signupScreen='/signupScreen';
  static const String productScreen='/productScreen';
  static const String orderScreen='/orderScreen';
}

class AppRouter{
    static Route<dynamic> generateRoute(RouteSettings settings){
      switch (settings.name){
        case AppRoutes.initialScreen:
          return MaterialPageRoute(builder: (_) => const SplashScreen());

          case AppRoutes.loginScreen:
          return MaterialPageRoute(builder: (_) => const LoginScreen());

          case AppRoutes.homeScreen:
          return MaterialPageRoute(builder: (_) => const MainScreen());

          case AppRoutes.signupScreen:
          return MaterialPageRoute(builder: (_) =>  const SignUpScreen());

          case AppRoutes.orderScreen:
          return MaterialPageRoute(builder: (_) =>  const OrderScreen());

          case AppRoutes.productScreen:
            final productId=(settings.arguments as Map<String,String>)['id'];
          return MaterialPageRoute(builder: (_) =>  ProductScreen(productId: productId??'',));

        default:
          return MaterialPageRoute(builder: (_)=>const MyApp());
      }
    }
}