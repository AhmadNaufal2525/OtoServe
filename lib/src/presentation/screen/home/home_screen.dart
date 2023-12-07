import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/home/widgets/promo_widget.dart';
import 'package:otoserve/src/presentation/screen/home/widgets/service_widget.dart';
import 'package:otoserve/src/presentation/screen/home/widgets/top_bengkel_widget.dart';
import 'package:otoserve/src/presentation/screen/home/widgets/wallet_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: 414.w,
                  height: 122.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                    color: AppColor.primaryColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0).w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hello Helga',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications_none_rounded,
                            color: Colors.white,
                            size: 22.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 80.h,
                ),
                const ServiceWidget(),
                SizedBox(
                  height: 28.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20).w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PromoWidget(),
                      const TopBengkelWidget(),
                      SizedBox(height: 18.h,),
                      Divider(thickness: 1, color: AppColor.dividerColor,)
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 90.h,
              left: 35.w,
              child: const WalletWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
