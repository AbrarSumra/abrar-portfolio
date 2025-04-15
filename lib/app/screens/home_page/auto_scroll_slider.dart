import 'dart:async';
import 'dart:math';

import 'package:abrar_portfolio/app/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/widgets/text_constant/text_constant.dart';
import '../../constants/widgets/widgets.dart';

/// _myIntroSection
class HoverAbleIcon extends StatefulWidget {
  final MapEntry<String, dynamic> socialPlatImg;
  final bool isMobile;

  const HoverAbleIcon({
    required this.socialPlatImg,
    required this.isMobile,
    super.key,
  });

  @override
  State<HoverAbleIcon> createState() => _HoverAbleIconState();
}

class _HoverAbleIconState extends State<HoverAbleIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    double baseSize = widget.isMobile ? 30 : 40;
    double hoverSize = widget.isMobile ? 40 : 50;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: isHovered ? hoverSize : baseSize,
        width: isHovered ? hoverSize : baseSize,
        child: GestureDetector(
          onTap: () async {
            final url =
                widget.socialPlatImg.value['url']; // Ensure this key exists
            if (await canLaunchUrl(Uri.parse(url))) {
              await launchUrl(Uri.parse(url));
            } else {
              throw 'Could not launch $url';
            }
          },
          child: Image.asset(
            widget.socialPlatImg.value['icon'],
            color: isHovered ? AppColor.kAppMainColor : AppColor.kDarkGreyColor,
          ),
        ),
      ),
    );
  }
}

class AutoScrollSlider extends StatefulWidget {
  const AutoScrollSlider({super.key});

  @override
  State<AutoScrollSlider> createState() => _AutoScrollSliderState();
}

class _AutoScrollSliderState extends State<AutoScrollSlider> {
  final ScrollController _scrollController = ScrollController();
  final List<String> _images = [
    'assets/png/flutter.png',
    'assets/png/dart.png',
    'assets/png/firebase.png',
    'assets/png/rest_apis.png',
    'assets/png/html.png',
    'assets/png/bootstrap.png',
    'assets/png/php.png',
  ];

  double _scrollPosition = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start scrolling
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (_) {
      _scrollPosition += 1;
      if (_scrollPosition >= _scrollController.position.maxScrollExtent) {
        _scrollPosition = 0;
        _scrollController.jumpTo(0);
      } else {
        _scrollController.jumpTo(_scrollPosition);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repeatedList =
        List.generate(100, (_) => _images).expand((i) => i).toList();

    final isMobile = MediaQuery.of(context).size.width < 600;

    return SizedBox(
      height: 80.h,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: repeatedList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(
              repeatedList[index],
              height: isMobile ? 40.h : 100.h,
              width: isMobile ? 80.h : 120.h,
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    );
  }
}

/// For _mySkillSection
class SkillShadowBox extends StatefulWidget {
  final double height;
  final double width;
  final double fontSize;
  final bool isMobile;
  final MapEntry<String, dynamic> name;

  const SkillShadowBox({
    required this.name,
    required this.isMobile,
    this.height = 200,
    this.width = 200,
    this.fontSize = 14,
    super.key,
  });

  @override
  State<SkillShadowBox> createState() => _SkillShadowBoxState();
}

class _SkillShadowBoxState extends State<SkillShadowBox> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        height: widget.isMobile ? 120.h : widget.height.h,
        width: widget.isMobile ? 120.h : widget.width.h,
        margin: EdgeInsets.all(20.h),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: isHovered ? AppColor.kAppMainLightColor : Colors.black54,
              blurRadius: 10,
              spreadRadius: 3,
              offset: Offset(4, 4),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.name.value,
              height: widget.isMobile ? 50.h : 80.h,
              width: widget.isMobile ? 100.h : 150.h,
            ),
            heightBox(20),
            NormalText(
              title: widget.name.key,
              fontSize: widget.fontSize,
              fontWeight: FontWeight.w800,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// For _portfolioSection
class PortfolioBox extends StatefulWidget {
  final double height;
  final double width;
  final double titleFontSize;
  final double contentFontSize;
  final bool isMobile;
  final MapEntry<String, dynamic> name;

  const PortfolioBox({
    required this.name,
    required this.isMobile,
    this.height = 200,
    this.width = 200,
    this.titleFontSize = 14,
    this.contentFontSize = 12,
    super.key,
  });

  @override
  State<PortfolioBox> createState() => _PortfolioBoxState();
}

class _PortfolioBoxState extends State<PortfolioBox>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  bool isFlipped = false;

  late AnimationController _controller;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: pi).animate(_controller);
  }

  void _flipCard() {
    if (isFlipped) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() => isFlipped = !isFlipped);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => isHovered = true);
        if (!isFlipped) _flipCard();
      },
      onExit: (_) {
        setState(() => isHovered = false);
        if (isFlipped) _flipCard();
      },
      child: GestureDetector(
        onTap: _flipCard,
        child: AnimatedBuilder(
          animation: _flipAnimation,
          builder: (context, child) {
            final isBack = _flipAnimation.value >= pi / 2;

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_flipAnimation.value),
              child: Container(
                height: widget.height.h,
                width: widget.width.h,
                margin: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: isHovered
                          ? Colors.blueAccent.withOpacity(0.3)
                          : Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 3,
                      offset: Offset(4, 4),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: isBack
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(pi),
                        child: _buildBack(),
                      )
                    : _buildFront(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFront() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              widget.name.value['bg-image'],
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: 85.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.kAppMainLightColor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
            ),
            padding: EdgeInsets.all(widget.isMobile ? 5.w : 1.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: widget.isMobile ? 40.h : 50.h,
                  width: widget.isMobile ? 40.h : 50.h,
                  decoration: BoxDecoration(
                    color: AppColor.kAppMainColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(widget.name.value['icon']),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                FittedBox(
                  child: NormalText(
                    title: widget.name.key,
                    fontSize: widget.titleFontSize,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBack() {
    return Padding(
      padding: EdgeInsets.all(12.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NormalText(
            title: '${widget.name.value['desc']}',
            fontSize: widget.contentFontSize,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          widget.isMobile ? heightBox(5) : heightBox(20),
          ElevatedButton(
            onPressed: () async {
              final url = widget.name.value['url']; // Ensure this key exists
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url));
              } else {
                throw 'Could not launch $url';
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: NormalText(
              title: "View Project",
              fontSize: widget.isMobile ? 12 : 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

/// For Get in Touch
class GetInTouchBox extends StatefulWidget {
  final double height;
  final double width;
  final MapEntry<String, dynamic> name;

  const GetInTouchBox({
    required this.name,
    this.height = 200,
    this.width = 200,
    super.key,
  });

  @override
  State<GetInTouchBox> createState() => _GetInTouchBoxState();
}

class _GetInTouchBoxState extends State<GetInTouchBox> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        height: widget.height.h,
        width: widget.width.h,
        margin: EdgeInsets.all(20.h),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: isHovered ? AppColor.kAppMainLightColor : Colors.black54,
              blurRadius: 10,
              spreadRadius: 3,
              offset: Offset(4, 4),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.name.value,
              size: 80.h,
              color: AppColor.kAppMainColor,
            ),
            heightBox(20),
            NormalText(
              title: widget.name.key,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ],
        ),
      ),
    );
  }
}
