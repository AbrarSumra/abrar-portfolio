import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors/app_colors.dart';

class KTextField extends StatefulWidget {
  const KTextField({
    super.key,
    this.labelText,
    this.obscureText = false,
    this.enable = true,
    this.textColor = AppColor.kFontBlack,
    this.controller,
    this.maxLength,
    this.maxLines = 1,
    this.labelTextColor = AppColor.kAppMainColor,
    this.keyboardType = TextInputType.text,
    this.borderColor,
    this.validator,
    this.onChanged,
  });

  final String? labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final bool enable;
  final int? maxLength;
  final int maxLines;
  final Color labelTextColor;
  final TextInputType keyboardType;
  final Color? borderColor;
  final Color textColor;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;

  @override
  State<KTextField> createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;

  Color get _currentLabelColor {
    if (_controller.text.isNotEmpty || _focusNode.hasFocus) {
      return widget.labelTextColor; // Main color
    }
    return AppColor.kGreyColor; // Grey color for hint
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = widget.controller ?? TextEditingController();

    _focusNode.addListener(() {
      if (mounted &&
          _focusNode.hasFocus !=
              (_currentLabelColor == widget.labelTextColor)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {}); // Only update when focus state actually changes
        });
      }
    });

    _controller.addListener(() {
      if (mounted &&
          _controller.text.isNotEmpty !=
              (_currentLabelColor == widget.labelTextColor)) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {}); // Only update when text state actually changes
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      controller: _controller,
      keyboardType: widget.keyboardType,
      style: GoogleFonts.quicksand(
          color: widget.textColor, fontWeight: FontWeight.w600),
      enabled: widget.enable,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      validator: widget.validator,
      onChanged: widget.onChanged,
      focusNode: _focusNode,
      decoration: InputDecoration(
        counterText: '',
        labelText: widget.labelText,
        labelStyle: GoogleFonts.quicksand(
            color: _currentLabelColor, fontWeight: FontWeight.w600),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColor.kGreyColor,
            width: 1.0,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.kAppRedColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
