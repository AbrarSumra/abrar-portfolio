import 'package:abrar_portfolio/app/constants/app_colors/app_colors.dart';
import 'package:abrar_portfolio/app/constants/widgets/custom_pressable_button.dart';
import 'package:abrar_portfolio/app/constants/widgets/text_constant/text_constant.dart';
import 'package:abrar_portfolio/app/constants/widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../../../constants/utils/resume_helper_web.dart';
import '../../../constants/widgets/hover_button.dart';

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? webActions;
  final VoidCallback? onHomeTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onSkillTap;
  final VoidCallback? onPortfolioTap;
  final VoidCallback? onContactTap;

  const ResponsiveAppBar({
    super.key,
    this.title = 'Abrar Khira',
    this.webActions,
    this.onHomeTap,
    this.onAboutTap,
    this.onSkillTap,
    this.onPortfolioTap,
    this.onContactTap,
  });

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.kWhiteColor,
      centerTitle: isMobile(context) ? true : false,
      title: NormalText(
        title: title,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      actions: isMobile(context)
          ? null
          : webActions ??
              [
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
                PressableButton(
                  title: 'RESUME',
                  width: 30,
                  height: 35,
                  btnColor: Colors.white,
                  borderColor: AppColor.kAppRedColor,
                  fontColor: AppColor.kDarkGreyColor,
                  fontWeight: FontWeight.w600,
                  onTap: () {
                    downloadWeb();
                  },
                ),
                widthBox(5),
              ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
