import 'package:abrar_portfolio/app/constants/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

import '../text_constant/text_constant.dart';

class FreeDeliveryBanner extends StatelessWidget {
  const FreeDeliveryBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/img/light_purple_background.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/pngs/free_delivery.png',
            height: 60,
          ),
          const SizedBox(width: 20),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NormalText(
                title: 'Free delivery',
                color: AppColor.kAppBlueColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              NormalText(
                title: 'from ₹200',
                color: AppColor.kAppBlueColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
