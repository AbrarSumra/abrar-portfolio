import 'package:abrar_portfolio/app/constants/app_colors/app_colors.dart';
import 'package:abrar_portfolio/app/constants/widgets/text_constant/text_constant.dart';
import 'package:abrar_portfolio/app/constants/widgets/widgets.dart';
import 'package:abrar_portfolio/app/screens/splash_screen/introduction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:abrar_portfolio/app/constants/app_keys/app_keys.dart';

import '../home_page/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if user is logged in (retrieve token as String)
    String? token = prefs.getString(AppKeys.loginSave);

    // Check if the introduction pages have been seen (retrieve as bool)
    bool hasSeenIntro = prefs.getBool(AppKeys.hasSeenIntro) ?? false;

    // Simulate a delay for the splash screen
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      if (token == null && !hasSeenIntro) {
        // Navigate to Introduction Pages if not seen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const IntroductionPages()),
        );
      } else {
        // Navigate to Login or Home Page based on token
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  token != null ? HomePage() : HomePage() // const LoginPage(),
              ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/logo/splash2.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/pngs/hospital.png',
              height: 100.h,
            ),
            heightBox(10),
            const NormalText(
              title: 'Clinic',
              fontSize: 24,
              color: AppColor.kAppLightBlueColor,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }
}
