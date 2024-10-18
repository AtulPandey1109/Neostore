import 'package:flutter/material.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/responsive_size_helper.dart';

class AppRoundedElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget label;
  final double? width;

  const AppRoundedElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? (SizeConfig.isMobile()
          ? MediaQuery.sizeOf(context).width * 0.8
          : MediaQuery.sizeOf(context).width * .3),
      child: ElevatedButton(
        onPressed: onPressed,
        style: kRoundedElevatedButtonStyle,
        child: label,
      ),
    );
  }
}
