import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoWidget extends StatelessWidget {
  final List<String> promoList = [
    'assets/images/promo.png',
    'assets/images/promo.png',
    'assets/images/promo.png',
  ];
  PromoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Event & Promo',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
            Text(
              'Lihat Semua',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 140.h,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: promoList.length,
            itemBuilder: (contex, index) {
              final promo = promoList[index];
              return Container(
                width: 248,
                margin: const EdgeInsets.only(right: 8.0).w,
                child: Row(
                  children: [
                    Image.asset(promo, width: 248.w),
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
