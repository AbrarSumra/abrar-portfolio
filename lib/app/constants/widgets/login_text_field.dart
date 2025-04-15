import 'package:flutter/material.dart';

import '../app_colors/app_colors.dart';

class KLoginTextField extends StatelessWidget {
  const KLoginTextField({
    super.key,
    this.hintText,
    this.controller,
    this.maxLength,
    this.maxLines,
    this.suffixIcon,
    this.hintTextColor = Colors.grey,
    this.iconColor = Colors.black,
    this.keyboardType = TextInputType.text,
    this.fontColor = AppColor.kDarkGreyColor,
    this.validator,
    this.obscureText = false,
  });

  final String? hintText;
  final bool obscureText;
  final IconButton? suffixIcon;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final Color hintTextColor;
  final Color fontColor;
  final Color iconColor;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(color: fontColor),
      maxLength: maxLength,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        counterText: '',
        hintStyle: TextStyle(color: hintTextColor),
        suffixIcon: suffixIcon,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.kAppMainColor,
            width: 2.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.kAppRedColor,
            width: 2.0,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
