import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/utils/colors.dart';

class ServiceWidget extends StatefulWidget {
  const ServiceWidget({super.key});

  @override
  State<ServiceWidget> createState() => _ServiceWidgetState();
}

class _ServiceWidgetState extends State<ServiceWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColor.dividerColor,
              child: Image.asset(
                'assets/icons/siren.png',
                width: 28.w,
                height: 28.h,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              'Emergency\nService',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColor.dividerColor,
              child: Image.asset(
                'assets/icons/service.png',
                width: 28.w,
                height: 28.h,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              'Home\nService',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColor.dividerColor,
              child: Image.asset(
                'assets/icons/location.png',
                width: 28.w,
                height: 28.h,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Text(
              'Find\nBengkel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
