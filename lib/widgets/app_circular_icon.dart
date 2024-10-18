import 'package:flutter/material.dart';


class AppCircularIcon extends StatelessWidget {
 final IconData icon;

  const AppCircularIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return  CircleAvatar(
      backgroundColor: Colors.white70,
      child: Icon(icon),

    );
  }
}
