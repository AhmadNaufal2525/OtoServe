import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/utils/colors.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 344.w,
      height: 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
        color: AppColor.saldoColor,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(21.0).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: Image.asset(
                        'assets/icons/wallet.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      'Saldo Anda',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Rp 50.000',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
          VerticalDivider(
            thickness: 1,
            color: AppColor.dividerColor,
          ),
          Row(
            children: [
              SizedBox(
                width: 14.w,
              ),
              SizedBox(
                height: 41.h,
                width: 41.w,
                child: Image.asset(
                  'assets/images/point.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                width: 14.w,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 21.0).w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Points',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      '75.500',
                      style: TextStyle(
                        color: AppColor.pointColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
