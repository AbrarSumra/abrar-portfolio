import 'package:flutter/material.dart';

import '../app_colors/app_colors.dart';

class CircleIconContainer extends StatelessWidget {
  const CircleIconContainer({
    super.key,
    required this.icon,
    this.iconSize = 20,
    this.iconColor = AppColor.kAppRedColor,
    this.containerColor = Colors.white,
    this.onTap,
  });

  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Color containerColor;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: containerColor,
          shape: BoxShape.circle,
          border: Border.all(
            width: 2,
            color: AppColor.kAppMainLightColor,
          ),
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
