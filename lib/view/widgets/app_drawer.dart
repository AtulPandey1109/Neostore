import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.profileScreen);
            },
            child: const ListTile(
              leading: Icon(Icons.person_outline),
              title: Text(
                'My Profile',
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.orderScreen);
            },
            leading: const Icon(Icons.delivery_dining_outlined),
            title: const Text(
              'My Orders',
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.wishlistScreen);
            },
            leading: const Icon(FontAwesomeIcons.heart),
            title: const Text(
              'My WishList',
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.contactUsScreen);
            },
            leading: const Icon(Icons.phone_outlined),
            title: const Text(
              'Contact Us',
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.privacyPolicyScreen);
            },
            leading: const Icon(Icons.lock_outline),
            title: const Text(
              'Privacy Policy',
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.faqsScreen);
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
