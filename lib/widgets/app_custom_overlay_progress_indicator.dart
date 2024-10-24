import 'package:flutter/material.dart';

import 'app_custom_circular_progress_indicator.dart';
class AppCustomOverlayProgressIndicator extends StatelessWidget {
  const AppCustomOverlayProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
        child:  Opacity(
          opacity: 0.5,
          child: Center(
            child: AppCustomCircularProgressIndicator(
              color: Colors.orange,
            ),
          ),
        ));
  }
}
