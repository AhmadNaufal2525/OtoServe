import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/utils/colors.dart';

class ServicesTypeWidget extends StatelessWidget {
  final String image;
  final String text;
  final Function() onTap;
  const ServicesTypeWidget({super.key, required this.image, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColor.dividerColor,
            child: Image.asset(
              image,
              width: 28.w,
              height: 28.h,
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
