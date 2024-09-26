import 'package:flutter/material.dart';

class AppCustomCircularProgressIndicator extends StatelessWidget {
  final Color color;
  const AppCustomCircularProgressIndicator({super.key, this.color =Colors.white});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 2,
      ),
    );
  }
}
