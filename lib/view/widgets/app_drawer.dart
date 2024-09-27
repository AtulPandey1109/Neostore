import 'package:flutter/material.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/utils/app_local_storage.dart';
import 'package:neostore/utils/constant_styles.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const ListTile(
            title: Text(
              'NeoStore',
              style: kHeader2TextStyle,
            ),
          ),
          const Divider(
            thickness: .6,
          ),
          const ListTile(
            leading: Icon(Icons.person_outline),
            title: Text(
              'Profile',
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, AppRoutes.orderScreen);
            },
            child: const ListTile(
              leading: Icon(Icons.delivery_dining_outlined),
              title: Text(
                'Orders',
              ),
            ),
          ),
          ListTile(
            textColor: Colors.orange,
            onTap: () async {
              AppLocalStorage.removeToken();
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreen,
                  (Route<dynamic> route) => false);
            },
            leading: const Icon(Icons.logout_outlined,color: Colors.orange,),
            title: const Text(
              'Logout',
              style: kTextButtonStyle,
            ),
          ),
        ],
      ),
    );
  }
}
