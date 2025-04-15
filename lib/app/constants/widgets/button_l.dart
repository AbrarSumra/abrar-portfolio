import 'package:abrar_portfolio/app/constants/widgets/text_constant/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors/app_colors.dart';

class ButtonL extends StatelessWidget {
  const ButtonL({
    super.key,
    required this.title,
    this.titleColor = AppColor.kWhiteColor,
    this.height = 50,
    this.width = double.infinity,
    required this.onTap,
    this.btnColor = AppColor.kAppRedColor,
    this.isLoading = false,
  });

  final String title;
  final Color titleColor;
  final double height;
  final double width;
  final Function()? onTap;
  final Color btnColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: isLoading ? null : onTap,
        child: isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              )
            : FittedBox(
                child: NormalText(
                  title: title,
                  fontSize: 18,
                  color: titleColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
