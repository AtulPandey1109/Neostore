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
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.orderScreen);
            },
            leading: const Icon(Icons.delivery_dining_outlined),
            title: const Text(
              'Orders',
            ),
          ),ListTile(
            onTap: () {

            },
            leading: const Icon(Icons.phone_outlined),
            title: const Text(
              'Contact Us',
            ),
          ),ListTile(
            onTap: () {

            },
            leading: const Icon(Icons.lock_outline),
            title: const Text(
              'Privacy Policy',
            ),
          ),ListTile(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.orderScreen);
            },
            leading: const Icon(Icons.question_answer_outlined),
            title: const Text(
              'FAQs',
            ),
          ),
          ListTile(
            textColor: Colors.orange,
            onTap: () async {
              AppLocalStorage.removeToken();
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreen,
                  (Route<dynamic> route) => false);
            },
            leading: const Icon(
              Icons.logout_outlined,
              color: Colors.orange,
            ),
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
