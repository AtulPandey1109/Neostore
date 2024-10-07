import 'package:flutter/material.dart';

import 'app_custom_circular_progress_indicator.dart';
class AppCustomOverlayProgressIndicator extends StatelessWidget {
  const AppCustomOverlayProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child:  Opacity(
          opacity: 0.5,
          child: Container(
            color: Colors.black12,
            child: const Center(
              child: AppCustomCircularProgressIndicator(
                color: Colors.orange,
              ),
            ),
          ),
        ));
  }
}
