import 'package:abrar_portfolio/app/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.color,
    this.iconColor = AppColor.kDarkGreyColor,
    this.onTap,
  });

  final Color? color;
  final IconData icon;
  final Color? iconColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.w,
      height: 42.h,
      margin: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: color ?? AppColor.kWhiteColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
