import 'package:abrar_portfolio/app/constants/app_colors/app_colors.dart';
import 'package:abrar_portfolio/app/constants/utils/image_path.dart';
import 'package:abrar_portfolio/app/constants/widgets/widgets.dart';
import 'package:abrar_portfolio/app/screens/common/drawer_page/drawer_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../constants/utils/data.dart';
import '../../constants/widgets/text_constant/text_constant.dart';
import '../common/app_bar/app_bar.dart';
import 'auto_scroll_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isHovered = false;
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillKey = GlobalKey();
  final GlobalKey portfolioKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: ResponsiveAppBar(
        onHomeTap: () => _scrollToSection(homeKey),
        onAboutTap: () => _scrollToSection(aboutKey),
        onSkillTap: () => _scrollToSection(skillKey),
        onPortfolioTap: () => _scrollToSection(portfolioKey),
        onContactTap: () => _scrollToSection(contactKey),
      ),
      drawer: isMobile
          ? DrawerPage(
              onHomeTap: () {
                _scrollToSection(homeKey);
                Navigator.pop(context);
              },
              onAboutTap: () {
                _scrollToSection(aboutKey);
                Navigator.pop(context);
              },
              onSkillTap: () {
                _scrollToSection(skillKey);
                Navigator.pop(context);
              },
              onPortfolioTap: () {
                _scrollToSection(portfolioKey);
                Navigator.pop(context);
              },
              onContactTap: () {
                _scrollToSection(contactKey);
                Navigator.pop(context);
              },
            )
          : null,
      backgroundColor: AppColor.kWhiteColor,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: kIsWeb
              ? EdgeInsets.symmetric(horizontal: 20.w)
              : EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// Intro Section
              KeyedSubtree(
                key: homeKey,
                child: Column(
                  children: [
                    isMobile
                        ? Stack(
                            children: [
                              _introSection(isMobile, isHovered),
                              Positioned(
                                right: 10,
                                top: 45.h,
                                child: ClipOval(
                                  child: Image.asset(
                                    ImagePath.introImgPath,
                                    width: 130.w,
                                    height: 130.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: _introSection(isMobile, isHovered)),
                              Column(
                                children: [
                                  heightBox(60),
                                  ClipOval(
                                    child: Image.asset(
                                      ImagePath.introImgPath,
                                      width: 100.w,
                                      height: 100.w,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                  ],
                ),
              ),
              heightBox(30),

              /// About Me Section
              KeyedSubtree(
                key: aboutKey,
                child: NormalText(
                  title: 'About Me',
                  fontSize: isMobile ? 25 : 50,
                ),
              ),
              NormalText(
                title: 'Get to know me :)',
                fontSize: isMobile ? 14 : 16,
              ),
              heightBox(40),
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImagePath.aboutImgPath,
                          height: 250,
                        ),
                        heightBox(20),
                        _descriptionSection(isMobile),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImagePath.aboutImgPath,
                          height: 500,
                        ),
                        widthBox(40),
                        Expanded(child: _descriptionSection(isMobile)),
                      ],
                    ),
              heightBox(40),

              /// My Skills Section
              KeyedSubtree(
                key: skillKey,
                child: _mySkillsSection(isMobile),
              ),

              /// Portfolio Section
              heightBox(40),
              KeyedSubtree(
                key: portfolioKey,
                child: _portfolioSection(isMobile),
              ),

              /// Get in Touch Section
              heightBox(40),
              KeyedSubtree(
                key: contactKey,
                child: _getInTouchSection(isMobile),
              ),
              heightBox(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NormalText(title: 'Developed with '),
                  Icon(
                    HeroIcons.heart,
                    color: AppColor.kAppMainColor,
                  ),
                  NormalText(
                    title: ' Flutter',
                    fontWeight: FontWeight.w600,
                    color: AppColor.kAppMainColor,
                  ),
                ],
              ),
              heightBox(10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _introSection(bool isMobile, bool isHovered) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isMobile ? heightBox(10) : heightBox(50),
        Row(
          children: [
            NormalText(
              title: 'WELCOME TO MY PORTFOLIO!',
              fontSize: isMobile ? 14 : 18,
            ),
            widthBox(2),
            Image.asset(
              'assets/gif/hello.gif',
              height: isMobile ? 40.h : 50.h,
              width: isMobile ? 40.h : 50.h,
            ),
          ],
        ),
        heightBox(20),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NormalText(
                  title: 'Khira',
                  fontSize: isMobile ? 25 : 50,
                ),
                NormalText(
                  title: 'Abrar',
                  fontSize: isMobile ? 30 : 60,
                  fontWeight: FontWeight.bold,
                ),
                heightBox(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.triangle_bold,
                      size: isMobile ? 20 : 25,
                    ),
                    widthBox(5),
                    SizedBox(
                      width: 280,
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TyperAnimatedText(
                            'A Flutter Developer',
                            textStyle: textStyle(
                              fontSize: isMobile ? 15 : 20,
                              color: AppColor.kDarkGreyColor,
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                          TyperAnimatedText(
                            'A Mobile App Enthusiast',
                            textStyle: textStyle(
                              fontSize: isMobile ? 15 : 20,
                              color: AppColor.kDarkGreyColor,
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                          TyperAnimatedText(
                            'A Passionate Coder',
                            textStyle: textStyle(
                              fontSize: isMobile ? 15 : 20,
                              color: AppColor.kDarkGreyColor,
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        heightBox(40),
        Row(
          children: socialPlatImg.entries
              .map((img) => Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: HoverAbleIcon(
                      socialPlatImg: img,
                      isMobile: isMobile,
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }

  Widget _descriptionSection(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalText(
          title: 'Who am i?',
          color: AppColor.kAppMainColor,
          fontSize: isMobile ? 16 : 18,
        ),
        NormalText(
          title: 'I\'m Abrar Khira, a Flutter Developer',
          color: AppColor.kDarkGreyColor,
          fontSize: isMobile ? 20 : 24,
          fontWeight: FontWeight.w600,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NormalText(
              title:
                  'A passionate and self-driven Flutter Developer with a background in BSc Chemistry. My journey into tech began with a strong curiosity for building digital experiences, which led me to complete a Flutter Development course at WsCube Tech, Rajasthan, where I learned to craft beautiful, responsive, and functional mobile apps. \nI further sharpened my skills through a Software Development program at IANT, Jamnagar, where I gained insights into broader programming concepts and best practices. Now, I’m focused on building intuitive cross-platform applications using Flutter, blending creativity with clean code. I’m always eager to grow, learn new technologies, and work on meaningful projects that make a difference. Let’s build something awesome together!',
              color: AppColor.kDarkGreyColor,
              fontSize: isMobile ? 12 : 14,
              textAlign: TextAlign.justify,
            ),
            heightBox(20),
            Divider(
              color: AppColor.kDarkGreyColor,
              height: 0,
            ),
            heightBox(10),
            NormalText(
              title: 'Technologies i have worked with :',
              color: AppColor.kAppRedColor,
              fontSize: isMobile ? 12 : 14,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.justify,
            ),
            heightBox(8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: techSkillsName.map((name) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      BoxIcons.bx_right_arrow,
                      color: AppColor.kAppMainColor,
                      size: 16,
                    ),
                    NormalText(
                      title: name,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ],
                );
              }).toList(),
            ),
            heightBox(10),
            Divider(
              color: AppColor.kDarkGreyColor,
              height: 0,
            ),
            heightBox(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    NormalText(
                      title: 'Name : ',
                      color: AppColor.kDarkGreyColor,
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.w800,
                      textAlign: TextAlign.justify,
                    ),
                    NormalText(
                      title: 'Abrar Khira',
                      color: AppColor.kAppMainColor,
                      fontSize: isMobile ? 12 : 14,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
                Row(
                  children: [
                    NormalText(
                      title: 'Email : ',
                      color: AppColor.kDarkGreyColor,
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.w800,
                      textAlign: TextAlign.justify,
                    ),
                    NormalText(
                      title: 'abrarkhira772@gmail.com',
                      color: AppColor.kAppMainColor,
                      fontSize: isMobile ? 12 : 14,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    NormalText(
                      title: 'Age : ',
                      color: AppColor.kDarkGreyColor,
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.w800,
                      textAlign: TextAlign.justify,
                    ),
                    NormalText(
                      title: '24',
                      color: AppColor.kAppMainColor,
                      fontSize: isMobile ? 12 : 14,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
                Row(
                  children: [
                    NormalText(
                      title: 'Address : ',
                      color: AppColor.kDarkGreyColor,
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.w800,
                      textAlign: TextAlign.justify,
                    ),
                    NormalText(
                      title: 'Kansumra',
                      color: AppColor.kAppMainColor,
                      fontSize: isMobile ? 12 : 14,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ],
            ),
            heightBox(15),
            AutoScrollSlider(),
          ],
        ),
        heightBox(20),
      ],
    );
  }

  Widget _mySkillsSection(bool isMobile) {
    return Column(
      children: [
        NormalText(
          title: 'What can i do ?',
          fontSize: isMobile ? 25 : 50,
        ),
        NormalText(
          title: 'I am not perfect but I can do it :)',
          fontSize: isMobile ? 14 : 16,
        ),
        heightBox(20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: mySkillsData.entries.map((name) {
            return SkillShadowBox(
              name: name,
              isMobile: isMobile,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _portfolioSection(bool isMobile) {
    return Column(
      children: [
        NormalText(
          title: 'Portfolio',
          fontSize: isMobile ? 25 : 50,
        ),
        NormalText(
          title: 'Here few samples of my work :)',
          fontSize: isMobile ? 14 : 16,
        ),
        heightBox(20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: myProjects.entries.map((name) {
            return PortfolioBox(
              name: name,
              isMobile: isMobile,
              titleFontSize: 16,
              height: 250,
              width: 350,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _getInTouchSection(bool isMobile) {
    return Column(
      children: [
        NormalText(
          title: 'Get in Touch',
          fontSize: isMobile ? 25 : 50,
        ),
        NormalText(
          title: 'Let\'s build something together :)',
          fontSize: isMobile ? 14 : 16,
        ),
        heightBox(20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: getInTouch.entries.map((name) {
            return GetInTouchBox(
              name: name,
              width: 350,
            );
          }).toList(),
        ),
      ],
    );
  }
}
