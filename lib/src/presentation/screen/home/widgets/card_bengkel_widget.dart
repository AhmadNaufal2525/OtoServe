import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardBengkelWidget extends StatelessWidget {
  final String image;
  final String text;
  final String rate;
  final String jarak;
  final String status;
  final Function() onTap;
  const CardBengkelWidget({
    super.key,
    required this.image,
    required this.text,
    required this.rate,
    required this.jarak,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 128.w,
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0).r,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0).r,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/bengkel.png',
                        width: 128.w,
                        height: 102.h,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                width: 28.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.yellow[600],
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        rate,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        jarak,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      color: status.toLowerCase() == 'buka sekarang'
                          ? Colors.green
                          : Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
