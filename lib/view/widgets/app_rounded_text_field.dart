import 'package:flutter/material.dart';
import 'package:neostore/utils/responsive_size_helper.dart';

class AppRoundedTextField extends StatelessWidget {

  final TextEditingController controller;
  final VoidCallback? onTap;
  final Function(PointerDownEvent)? onTapOutside;
  final IconData? icon;
  final String? labelText;
  final bool obscureText;
  final Function(String) ?onChange;
  const AppRoundedTextField({
    super.key,
    required this.controller,
    this.icon,
    this.labelText,
    this.obscureText =false,
this.onTap,
    this.onChange,
    this.onTapOutside
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.isMobile()
          ? MediaQuery.sizeOf(context).width * 0.8
          : MediaQuery.sizeOf(context).width * .3,
      child: TextFormField(
        // textAlignVertical: TextAlignVertical.top,
        maxLines: 1,
        obscureText: obscureText,
        controller: controller,
        onTap: onTap,
        onChanged: onChange,
        onTapOutside:onTapOutside?? (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
            isDense: true,
            label:  Text('$labelText',overflow: TextOverflow.ellipsis,),
            suffixIcon: Icon(icon,size: 24,),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16))),
      ),
    );
  }
}