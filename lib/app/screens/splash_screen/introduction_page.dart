import 'package:abrar_portfolio/app/constants/app_colors/app_colors.dart';
import 'package:abrar_portfolio/app/constants/widgets/text_constant/text_constant.dart';
import 'package:abrar_portfolio/app/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_keys/app_keys.dart';

class IntroductionPages extends StatefulWidget {
  const IntroductionPages({super.key});

  @override
  State<IntroductionPages> createState() => _IntroductionPagesState();
}

class _IntroductionPagesState extends State<IntroductionPages> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _titles = [
    'Meet Our Doctors',
    'Facilities & Services',
  ];

  final List<String> _desc = [
    'Explore doctors’ profiles, specialties, and experience before your visit.',
    'Discover the treatments and services offered \nat the clinic.',
  ];

  final List<String> _images = [
    'assets/pngs/medical-team.png',
    'assets/pngs/hospital.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/logo/splash2.jpg'),
            fit: BoxFit.cover, // Ensure the image covers the entire screen
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _titles.length,
                itemBuilder: (context, index) {
                  return _buildIntroPage(
                      imagePath: _images[index],
                      title: _titles[index],
                      desc: _desc[index]);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColor.kAppPurpleColor,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Skip Button
            TextButton(
              onPressed: () async {
                await _completeIntroduction(context);
              },
              child: const NormalText(
                title: 'SKIP',
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            // Page Indicators (Dots)
            Row(
              children: List.generate(
                _titles.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppColor.kAppRedColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
            // Get Started or Next Button
            // ElevatedButton(
            //   onPressed: () async {
            //     if (_currentPage == _titles.length - 1) {
            //       // On the last page, complete the introduction
            //       await _completeIntroduction(context);
            //     } else {
            //       // Move to the next page
            //       _pageController.nextPage(
            //         duration: const Duration(milliseconds: 300),
            //         curve: Curves.easeInOut,
            //       );
            //     }
            //   },
            //   child: Text(
            //       _currentPage == _titles.length - 1 ? 'Get Started' : 'Next'),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroPage(
      {required String imagePath,
      required String title,
      required String desc}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: 250,
        ),
        const SizedBox(height: 50),
        NormalText(
          title: title,
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 300,
          child: NormalText(
            title: desc,
            fontSize: 18,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Future<void> _completeIntroduction(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Navigate to the appropriate screen based on login state
    var token = prefs.getString(AppKeys.loginSave);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              token != null ? HomePage() : HomePage() //const LoginPage(),
          ),
    );
  }
}
