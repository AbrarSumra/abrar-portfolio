import 'package:abrar_portfolio/app/constants/widgets/text_constant/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors/app_colors.dart';

class PressableButton extends StatefulWidget {
  const PressableButton({
    super.key,
    required this.title,
    this.onTap,
    this.btnColor = AppColor.kAppMainColor,
    this.fontColor = AppColor.kWhiteColor,
    this.isLoading = false,
    this.height = 50.0,
    this.width = 160.0,
    this.fontSize = 18.0,
    this.fontWeight = FontWeight.w500,
    this.borderRadius = 5.0,
    this.borderColor = AppColor.kAppMainColor,
  });

  final String title;
  final Function()? onTap;
  final Color btnColor;
  final Color fontColor;
  final bool isLoading;
  final double height;
  final double width;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderRadius;
  final Color borderColor;

  @override
  State<PressableButton> createState() => _PressableButtonState();
}

class _PressableButtonState extends State<PressableButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isLoading ? null : widget.onTap,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 50),
        child: Container(
          height: widget.height.h,
          width: widget.width.w,
          decoration: BoxDecoration(
            color: widget.isLoading ? AppColor.kGreyColor : widget.btnColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(color: widget.borderColor, width: 2),
          ),
          alignment: Alignment.center,
          child: widget.isLoading
              ? SizedBox(
                  height: widget.height.h,
                  width: widget.width.h,
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                )
              : NormalText(
                  title: widget.title,
                  color: widget.fontColor,
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight,
                ),
        ),
      ),
    );
  }
}
