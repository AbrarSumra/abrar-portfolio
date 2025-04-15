import 'package:abrar_portfolio/app/constants/widgets/text_constant/text_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer({
    super.key,
    required this.index,
    required this.email,
    required this.msg,
    this.imgUrl = '',
    required this.formattedDate,
    required this.formattedTime,
  });

  final int index;
  final String formattedDate;
  final String formattedTime;
  final String email;
  final String msg;
  final String? imgUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: (index % 2 == 0) ? Colors.red.shade100 : Colors.black12,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        NormalText(
                          title: email,
                          color: CupertinoColors.activeBlue,
                          fontWeight: FontWeight.w500,
                        ),
                        const Spacer(),
                        NormalText(
                          title: formattedDate,
                          fontSize: 12,
                          color: CupertinoColors.activeBlue,
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: NormalText(
                            title: msg,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        imgUrl != ''
                            ? Image.network(
                                imgUrl!,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                fit: BoxFit.cover,
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NormalText(
                title: formattedTime,
                fontSize: 12,
                color: CupertinoColors.systemPink,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
