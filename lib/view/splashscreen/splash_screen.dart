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
  void validateToken() async{
    var token = await AppLocalStorage.getToken();
    dio.options.headers["authorization"] = "Bearer $token";
    try{
      Response response = await dio.get('${AppConstants.baseurl}/category');
      if(response.statusCode==200 && context.mounted){
        _navigateToHomeScreen();
      }
    } catch (e){
      if(context.mounted){
       _navigateToLoginScreen();
      }

    }
  }

  void _navigateToHomeScreen() {
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen,(Route<dynamic> route) => false);
  }

  void _navigateToLoginScreen(){
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreen,(Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    validateToken();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('This is splash screen'),
      ),
    );
  }
}
