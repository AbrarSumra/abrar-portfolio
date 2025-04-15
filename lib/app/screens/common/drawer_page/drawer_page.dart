import 'package:abrar_portfolio/app/constants/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/app_colors/app_colors.dart';
import '../../../constants/widgets/custom_pressable_button.dart';
import '../../../constants/widgets/hover_button.dart';
import '../../../constants/widgets/text_constant/text_constant.dart';

class DrawerPage extends StatelessWidget {
  final VoidCallback? onHomeTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onSkillTap;
  final VoidCallback? onPortfolioTap;
  final VoidCallback? onContactTap;

  const DrawerPage({
    super.key,
    this.onHomeTap,
    this.onAboutTap,
    this.onSkillTap,
    this.onPortfolioTap,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.kWhiteColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColor.kAppMainColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 35.r,
                  backgroundImage: AssetImage('assets/png/abrar.jpg'),
                ),
                widthBox(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NormalText(
                      title: 'Abrar Khira',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColor.kWhiteColor,
                    ),
                    NormalText(
                      title: 'abrarkhira772@gmail.com',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.kWhiteColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
          HoverButton(
            label: 'HOME',
            onPressed: onHomeTap!,
            textColor: AppColor.kAppMainColor,
          ),
          HoverButton(
            label: 'ABOUT',
            onPressed: onAboutTap!,
            textColor: AppColor.kAppMainColor,
          ),
          HoverButton(
            label: 'SKILLS',
            onPressed: onSkillTap!,
            textColor: AppColor.kAppMainColor,
          ),
          HoverButton(
            label: 'PROJECTS',
            onPressed: onPortfolioTap!,
            textColor: AppColor.kAppMainColor,
          ),
          HoverButton(
            label: 'CONTACT',
            onPressed: onContactTap!,
            textColor: AppColor.kAppMainColor,
          ),
          heightBox(20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: PressableButton(
              title: 'RESUME',
              width: 30,
              height: 35,
              btnColor: Colors.white,
              borderColor: AppColor.kAppRedColor,
              fontColor: AppColor.kDarkGreyColor,
              fontWeight: FontWeight.w600,
              onTap: () {
                /*html.AnchorElement anchorElement =
                    html.AnchorElement(href: 'assets/resume.pdf')
                      ..setAttribute('download', 'Abrar_Khira_Resume.pdf')
                      ..click();*/
              },
            ),
          ),
        ],
      ),
    );
  }
}
