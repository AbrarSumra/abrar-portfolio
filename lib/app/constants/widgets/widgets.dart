import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget heightBox(double height) {
  return SizedBox(height: height.h);
}

Widget widthBox(double width) {
  return SizedBox(width: width.w);
}

Widget socialIcons({required String img, VoidCallback? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Image.asset(
      img,
      height: 40,
      width: 40,
    ),
  );
}
