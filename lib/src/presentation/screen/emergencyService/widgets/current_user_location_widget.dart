import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/utils/colors.dart';

class CurrentUserLocationWidget extends StatelessWidget {
  final String type;
  final String alamat;
  final String phone;
  const CurrentUserLocationWidget({super.key, required this.type, required this.alamat, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 364.w,
      height: 90.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0).w,
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundColor: AppColor.dividerColor,
              child: const Icon(
                Icons.person_2_rounded,
                size: 40,
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0.sp,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  alamat,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0.sp,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  phone,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0.sp,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
