import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:otoserve/src/utils/colors.dart';

class NavigasiBengkelWidget extends StatelessWidget {
  final String nama;
  final String imageUrl;
  final String jarak;
  final String rating;
  final String status;
  const NavigasiBengkelWidget(
      {super.key,
      required this.nama,
      required this.imageUrl,
      required this.jarak,
      required this.rating,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/maps_1.png',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: CircleAvatar(
                  backgroundColor: AppColor.dividerColor,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 700.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: 380.w,
                      height: 130.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0.r)),
                        color: AppColor.containerColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0).w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0).r,
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 70,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/bengkel.png',
                                    width: 128.w,
                                    height: 102.h,
                                  );
                                },
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        nama,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            rating,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    status,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    '$jarak dari lokasimu',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    'Estimasi tiba: 50 Menit',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
