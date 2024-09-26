import 'package:flutter/material.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/utils/app_local_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(onPressed:  () async {
            AppLocalStorage.removeToken();
             Navigator.pushNamedAndRemoveUntil(context,
                AppRoutes.loginScreen, (Route<dynamic> route) => false);
           }, child: const Text('Logout')),
    );
  }
}
