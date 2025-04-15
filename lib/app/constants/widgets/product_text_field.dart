import 'package:flutter/material.dart';

import '../app_colors/app_colors.dart';

class KProductTextField extends StatefulWidget {
  const KProductTextField({
    super.key,
    this.hintText,
    this.icon,
    this.controller,
    this.maxLines,
    this.suffixIcon,
    this.obscureText = false,
    this.hintTextColor = Colors.grey,
    this.iconColor = Colors.black,
    this.keyboardType = TextInputType.text,
    this.fontColor = AppColor.kDarkGreyColor,
    this.validator,
  });

  final String? hintText;
  final IconData? icon;
  final IconButton? suffixIcon;
  final TextEditingController? controller;
  final int? maxLines;
  final bool obscureText;
  final Color hintTextColor;
  final Color fontColor;
  final Color iconColor;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  State<KProductTextField> createState() => _KProductTextFieldState();
}

class _KProductTextFieldState extends State<KProductTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      style: TextStyle(color: widget.fontColor),
      obscureText: widget.obscureText,
      maxLines: widget.maxLines,
      focusNode: _focusNode, // Attach the FocusNode
      decoration: InputDecoration(
        labelText: widget.hintText,
        labelStyle: TextStyle(
          color: _isFocused ? AppColor.kAppRedColor : AppColor.kGreyColor,
        ),
        hintStyle: TextStyle(color: widget.hintTextColor),
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                onPressed: widget.suffixIcon?.onPressed,
                icon: widget.suffixIcon!.icon,
                color: _isFocused ? AppColor.kAppRedColor : AppColor.kGreyColor,
              )
            : null,
        prefixIcon: Icon(
          widget.icon,
          color: widget.iconColor,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.kDarkGreyColor,
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
      validator: widget.validator,
    );
  }
}
