import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/bengkel_emergency_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

class WaitingEmergencyWidget extends StatelessWidget {
  const WaitingEmergencyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BengkelEmergencyWidget(),
          ),
        );
      },
    );
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
                'https://lottie.host/dc5e59c5-bc44-4aad-81b7-422e40f03699/5NdgJj2gXY.json'),
            Text(
              'Memproses Emergency Service\nMohon tunggu....',
              style: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.w700,
                fontSize: 20.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
