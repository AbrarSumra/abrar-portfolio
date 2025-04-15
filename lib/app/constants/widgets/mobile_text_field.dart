import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors/app_colors.dart';

class KMobileTextField extends StatelessWidget {
  const KMobileTextField({
    super.key,
    this.hintText,
    this.icon,
    this.controller,
    this.maxLength,
    this.maxLines,
    this.suffixIcon,
    this.obscureText = false,
    this.enable = true,
    this.hintTextColor = Colors.grey,
    this.iconColor = Colors.black,
    this.keyboardType = TextInputType.text,
    this.fontColor = AppColor.kDarkGreyColor,
    this.validator,
    this.onChanged,
    this.borderColor = AppColor.kDarkGreyColor,
  });

  final String? hintText;
  final IconData? icon;
  final IconButton? suffixIcon;
  final TextEditingController? controller;
  final int? maxLength;
  final int? maxLines;
  final bool obscureText;
  final bool enable;
  final Color hintTextColor;
  final Color fontColor;
  final Color iconColor;
  final Color borderColor;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      enabled: enable,
      style:
          GoogleFonts.quicksand(color: fontColor, fontWeight: FontWeight.w500),
      maxLength: maxLength,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        counterText: '',
        hintStyle: TextStyle(color: hintTextColor),
        suffixIcon: suffixIcon,
        prefixIcon: Icon(
          icon,
          color: iconColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor,
            width: 2.0,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.kDarkGreyColor,
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
      onChanged: onChanged,
    );
  }
}
