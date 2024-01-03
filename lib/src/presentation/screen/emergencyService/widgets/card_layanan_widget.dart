import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/utils/colors.dart';

class CardLayananWidget extends StatelessWidget {
  final String image;
  final String text;
  final String price;
  final Function() onPressed;
  const CardLayananWidget(
      {super.key,
      required this.image,
      required this.text,
      required this.price,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0).w,
      child: Container(
        width: 180.w,
        height: 110.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0).r,
            color: AppColor.dividerColor),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0.r),
                child: Container(
                  width: 100.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: AppColor.dividerColor,
                  ),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/bengkel.png',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  'Rp.$price',
                  style: const TextStyle(color: Colors.orange),
                ),
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    minimumSize: Size(80.w, 30.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      side: BorderSide.none,
                    ),
                  ),
                  child: Text(
                    'Pilih Layanan',
                    style: TextStyle(fontSize: 12.sp, color: Colors.white),
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
