import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/utils/colors.dart';
import 'package:otoserve/src/widgets/bottom_navigation_widget.dart';

class SucessfullPayment extends StatefulWidget {
  const SucessfullPayment({super.key});

  @override
  State<SucessfullPayment> createState() => _SucessfullPaymentState();
}

class _SucessfullPaymentState extends State<SucessfullPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Pembayaran',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0).w,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 200.h,),
              const CircleAvatar(
                radius: 30,
                backgroundColor: Color(0xff41D195),
                child: Icon(
                  Icons.done,
                  color: Colors.black,
                  size: 40,
                ),
              ),
              SizedBox(height: 20.h,),
              Text(
                'Pembayaran Berhasil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h,),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomNavigationWidget(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.purpleColor,
                    minimumSize: Size(300.w, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      side: BorderSide.none,
                    ),
                  ),
                  child: const Text(
                    'Kembali ke Home',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
