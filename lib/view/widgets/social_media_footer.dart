import 'package:flutter/material.dart';



class SocialMediaFooter extends StatelessWidget {
  const SocialMediaFooter({super.key, required this.icon});
final Icon icon;
  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 16.0),
        child: CircleAvatar(backgroundColor: Colors.white70,child:icon,)
    );
  }
}
