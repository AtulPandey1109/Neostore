import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/app_local_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Dio dio = Dio();
  double width=50;
  double height=50;
  void validateToken() async {
    await Future.delayed(const Duration(seconds: 1));
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    try {
      Response response = await dio.get('${AppConstants.baseurl}/category');
      if (response.statusCode == 200 && context.mounted) {
        _navigateToHomeScreen();
      }
    } catch (e) {
      if (context.mounted) {
        _navigateToLoginScreen();
      }
    }
  }

  void _navigateToHomeScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.homeScreen, (Route<dynamic> route) => false);
  }

  void _navigateToLoginScreen() {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.loginScreen, (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    validateToken();
    WidgetsBinding.instance.addPostFrameCallback((_){
      animateImage();
    });
  }
void animateImage() {
    setState(() {
      height=100;
      width= 400;
    });

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            height: height,
            width: width,
            curve: Curves.bounceOut,
            child: Image.asset(
              'assets/images/logo.png',
             fit: BoxFit.contain,
            ),
          ),
        ));
  }
}
