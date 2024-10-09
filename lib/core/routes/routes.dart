import 'package:flutter/material.dart';
import 'package:neostore/main.dart';
import 'package:neostore/model/cart_product_model/cart_product.dart';
import 'package:neostore/model/product_model/product_model.dart';
import 'package:neostore/view/category/all_category_screen.dart';
import 'package:neostore/view/contact_us/contact_us_screen.dart';
import 'package:neostore/view/faqs/faqs_screen.dart';
import 'package:neostore/view/login/login_screen.dart';
import 'package:neostore/view/main/main_screen.dart';
import 'package:neostore/view/order/order_screen.dart';
import 'package:neostore/view/order/order_summary_screen.dart';
import 'package:neostore/view/privacy_policy/privacy_policy_screen.dart';
import 'package:neostore/view/product/all_products_screen.dart';
import 'package:neostore/view/product/product_screen.dart';
import 'package:neostore/view/product/products_by_category_screen.dart';
import 'package:neostore/view/profile/profile_screen.dart';
import 'package:neostore/view/sign_up/sign_up_screen.dart';
import 'package:neostore/view/splashscreen/splash_screen.dart';
import 'package:neostore/view/wishlist/wishlist_screen.dart';






class AppRoutes{
  static const String initialScreen='/';
  static const String loginScreen='/loginScreen';
  static const String homeScreen='/homeScreen';
  static const String signupScreen='/signupScreen';
  static const String productScreen='/productScreen';
  static const String orderScreen='/orderScreen';
  static const String allCategoryScreen='/allCategoryScreen';
  static const String orderSummaryScreen='/orderSummaryScreen';
  static const String allProductsScreen='/allProductsScreen';
  static const String productByCategory='/productByCategory';
  static const String profileScreen='/profileScreen';
  static const String faqsScreen='/faqsScreen';
  static const String wishlistScreen='/wishlistScreen';
  static const String privacyPolicyScreen='/privacyPolicyScreen';
  static const String contactUsScreen='/contactUsScreen';
  static const String particularProductsScreen ='/particularProductsScreen';

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

          case AppRoutes.faqsScreen:
          return MaterialPageRoute(builder: (_) =>   const FaqsScreen());

          case AppRoutes.wishlistScreen:
          return MaterialPageRoute(builder: (_) =>  const WishlistScreen());

          case AppRoutes.privacyPolicyScreen:
          return MaterialPageRoute(builder: (_) =>  const PrivacyPolicyScreen());

          case AppRoutes.contactUsScreen:
          return MaterialPageRoute(builder: (_) =>  const ContactUsScreen());


        case AppRoutes.allCategoryScreen:
          final arguments = settings.arguments as dynamic;
          return MaterialPageRoute(builder: (_) =>   AllCategoryScreen(id:arguments==null?null:arguments['id'],name:arguments==null?null:arguments['name'],));

        case AppRoutes.orderSummaryScreen:
          List<CartProduct> products = (settings.arguments as Map<String,List<CartProduct>>)['data']??[];
          return MaterialPageRoute(builder: (_) =>  OrderSummaryScreen(products: products,));

        case AppRoutes.allProductsScreen:
          return MaterialPageRoute(builder: (_) =>  const AllProductsScreen());
          
        case AppRoutes.productByCategory:
          final subCategoryId=(settings.arguments as Map<String,String?>)['subCategoryId'];
          return MaterialPageRoute(builder: (_) =>  ProductsByCategoryScreen(subCategoryId: subCategoryId,));

        case AppRoutes.profileScreen:
          return MaterialPageRoute(builder: (_) =>  const ProfileScreen());


          case AppRoutes.productScreen:
            final productId=(settings.arguments as Map<String,String>)['id'];
          return MaterialPageRoute(builder: (_) =>  ProductScreen(productId: productId??'',));

        default:
          return MaterialPageRoute(builder: (_)=>const MyApp());
      }
    }
}