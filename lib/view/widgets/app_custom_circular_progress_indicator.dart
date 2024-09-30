import 'package:flutter/material.dart';

class AppCustomCircularProgressIndicator extends StatelessWidget {
  final Color color;
  const AppCustomCircularProgressIndicator({super.key, this.color =Colors.white});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: 2,
        ),
      ),
    );
  }
}
