import 'package:abrar_portfolio/app/constants/app_colors/app_colors.dart';
import 'package:abrar_portfolio/app/constants/widgets/text_constant/text_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleTextContainer extends StatelessWidget {
  const CircleTextContainer({
    super.key,
    required this.text,
    this.color = Colors.grey,
  });

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: NormalText(
        title: text,
        color: color,
      ),
    );
  }
}

class ContainerTickMark extends StatelessWidget {
  const ContainerTickMark({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: AppColor.kAppMainColor,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        CupertinoIcons.checkmark_alt,
        size: 15,
        color: Colors.white,
      ),
    );
  }
}
