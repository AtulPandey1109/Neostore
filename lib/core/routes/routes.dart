import 'package:flutter/material.dart';
import 'package:neostore/address/view/address_screen.dart';
import 'package:neostore/authentication/login/view/login_screen.dart';
import 'package:neostore/authentication/signup/view/sign_up_screen.dart';
import 'package:neostore/cart/model/cart_product_model/cart_product.dart';
import 'package:neostore/contact_us/contact_us_screen.dart';
import 'package:neostore/faqs/faqs_screen.dart';
import 'package:neostore/main.dart';
import 'package:neostore/main_screen/main_screen.dart';
import 'package:neostore/order/model/order_model/order_summary_model.dart';
import 'package:neostore/order/view/checkout_screen.dart';
import 'package:neostore/order/view/my_orders_screen.dart';
import 'package:neostore/order/view/order_summary/order_summary_screen.dart';
import 'package:neostore/privacy_policy/privacy_policy_screen.dart';
import 'package:neostore/product/view/all_products_screen.dart';
import 'package:neostore/product/view/product_screen.dart';
import 'package:neostore/product/view/products_by_category_screen.dart';
import 'package:neostore/product_category/view/all_category_screen.dart';
import 'package:neostore/splashscreen/splash_screen.dart';
import 'package:neostore/user_profile/view/profile/profile_screen.dart';
import 'package:neostore/wishlist/view/wishlist_screen.dart';








class AppRoutes{
  static const String initialScreen='/';
  static const String loginScreen='/loginScreen';
  static const String homeScreen='/homeScreen';
  static const String signupScreen='/signupScreen';
  static const String productScreen='/productScreen';
  static const String myOrdersScreen='/myOrdersScreen';
  static const String allCategoryScreen='/allCategoryScreen';
  static const String checkoutScreen='/checkoutScreen';
  static const String allProductsScreen='/allProductsScreen';
  static const String productByCategory='/productByCategory';
  static const String profileScreen='/profileScreen';
  static const String faqsScreen='/faqsScreen';
  static const String wishlistScreen='/wishlistScreen';
  static const String privacyPolicyScreen='/privacyPolicyScreen';
  static const String contactUsScreen='/contactUsScreen';
  static const String particularProductsScreen ='/particularProductsScreen';
  static const String addressScreen ='/addressScreen';
  static const String orderSummary ='/orderSummary';

}

class AppRouter{
    static Route<dynamic> generateRoute(RouteSettings settings){
      switch (settings.name){
        case AppRoutes.initialScreen:
          return MaterialPageRoute(builder: (_) => const SplashScreen());

          case AppRoutes.loginScreen:
          return MaterialPageRoute(builder: (_) => const LoginScreen());

          case AppRoutes.homeScreen:
          return MaterialPageRoute(builder: (_) =>  const MainScreen());

          case AppRoutes.signupScreen:
          return MaterialPageRoute(builder: (_) =>  const SignUpScreen());

          case AppRoutes.myOrdersScreen:
          return MaterialPageRoute(builder: (_) =>  const MyOrdersScreen());

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

        case AppRoutes.checkoutScreen:
          List<CartProduct> products = (settings.arguments as Map<String,dynamic>)['data']??[];
          String cartId =(settings.arguments as Map<String,dynamic>)['id']??'';
          return MaterialPageRoute(builder: (_) =>  CheckoutScreen(products: products,cartId:cartId));

        case AppRoutes.allProductsScreen:
          return MaterialPageRoute(builder: (_) =>  const AllProductsScreen());
          
        case AppRoutes.productByCategory:
          final subCategoryId=(settings.arguments as Map<String,String?>)['subCategoryId'];
          return MaterialPageRoute(builder: (_) =>  ProductsByCategoryScreen(subCategoryId: subCategoryId,));

        case AppRoutes.profileScreen:
          return MaterialPageRoute(builder: (_) =>  const ProfileScreen());

        case AppRoutes.addressScreen:
          final Address? address = settings.arguments==null?null:(settings.arguments as Map<String,Address>)['address'];
          return MaterialPageRoute(builder: (_) =>  AddressScreen(address: address,));


          case AppRoutes.productScreen:
            final productId=(settings.arguments as Map<String,String>)['id'];
          return MaterialPageRoute(builder: (_) =>  ProductScreen(productId: productId??'',));

          case AppRoutes.orderSummary:
            final orderId=(settings.arguments as Map<String,String?>)['id'];
          return MaterialPageRoute(builder: (_) =>  OrderSummaryScreen(orderId: orderId??'',));

        default:
          return MaterialPageRoute(builder: (_)=>const MyApp());
      }
    }
}