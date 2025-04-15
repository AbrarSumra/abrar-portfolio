import 'package:flutter/material.dart';

import 'app/constants/app_colors/app_colors.dart';
import 'app/constants/widgets/button_l.dart';
import 'app/constants/widgets/text_constant/text_constant.dart';

class NetworkPage extends StatelessWidget {
  const NetworkPage({
    super.key,
    required this.onRetry,
  });

  final Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kAppLightOrangeColor,
      body: ListView(
        children: [
          Container(
            height: 13,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 80),
                Image.asset(
                  'assets/pngs/no-network.png',
                  height: 300,
                ),
                const SizedBox(height: 20),
                const NormalText(
                  title: 'No Internet connection',
                  fontSize: 24,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                  color: AppColor.kAppBlueColor,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: NormalText(
                    title: 'Please check your internet settings',
                    fontSize: 18,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w600,
                    color: AppColor.kGreyColor,
                  ),
                ),
                const SizedBox(height: 30),
                ButtonL(
                  title: 'Retry',
                  onTap: onRetry,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
