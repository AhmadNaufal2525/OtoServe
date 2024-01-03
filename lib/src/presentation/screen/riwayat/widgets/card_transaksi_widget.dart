import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/utils/colors.dart';

class CardTransaksiWidget extends StatelessWidget {
  final String type;
  final String status;
  final String time;
  final String orderId;
  final String payment;
  const CardTransaksiWidget({super.key, required this.status, required this.type, required this.time, required this.orderId, required this.payment});

  Color getStatusTextColor() {
    switch (status.toLowerCase()) {
      case 'success':
        return const Color(0xff41D195);
      case 'pending':
        return Colors.yellow;
      default:
        return Colors.black;
    }
  }

  Color getStatusColor() {
    switch (status.toLowerCase()) {
      case 'success':
        return const Color.fromARGB(111, 76, 175, 79);
      case 'pending':
        return const Color.fromARGB(
          111,
          255,
          241,
          118,
        );
      default:
        return Colors.black;
    }
  }

  

  @override
Widget build(BuildContext context) {
  return Column(
    children: [
      SizedBox(height: 20.h),
      Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: AppColor.dividerColor,
            ),
            child: Image.asset(
              'assets/icons/siren.png',
              width: 35.w,
              height: 35.h,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '-Rp $payment',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        color: AppColor.textfieldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 30.w),
                    Expanded(
                      child: Text(
                        'Order ID : ${orderId.substring(0, 1)}****${orderId.substring(orderId.length - 1)}',
                        style: TextStyle(
                          color: AppColor.textfieldColor,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Text(
                      'Status Transaksi',
                      style: TextStyle(
                        color: AppColor.textfieldColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 76.w),
                    Container(
                      width: 70.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0.r),
                        color: getStatusColor(),
                      ),
                      child: Center(
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: getStatusTextColor(),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(width: 30.w),
        ],
      ),
      SizedBox(height: 10.h),
      Divider(
        thickness: 1,
        color: AppColor.dividerColor,
      ),
    ],
  );
}
}
