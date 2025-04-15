import 'package:abrar_portfolio/app/constants/app_colors/app_colors.dart';
import 'package:abrar_portfolio/app/constants/widgets/text_constant/text_constant.dart';
import 'package:flutter/material.dart';

class HoverButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final Color hoverColor;
  final Color textColor;

  const HoverButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.hoverColor = AppColor.kAppMainColor,
    this.textColor = AppColor.kDarkGreyColor,
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _isHovered ? widget.hoverColor : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: NormalText(
            title: widget.label,
            color: _isHovered ? AppColor.kWhiteColor : widget.textColor,
          ),
        ),
      ),
    );
  }
}
