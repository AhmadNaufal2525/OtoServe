import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/current_user_location_widget.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/sos_button_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

class EmergencyServiceScreen extends StatefulWidget {
  const EmergencyServiceScreen({super.key});

  @override
  State<EmergencyServiceScreen> createState() => _EmergencyServiceScreenState();
}

class _EmergencyServiceScreenState extends State<EmergencyServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
        toolbarHeight: 100.h,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Hello Helga',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
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
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Are you in emergency? ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
      backgroundColor: AppColor.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 17.h,
          ),
          Text(
            'Jika kamu mengalami situasi darurat kamu dapat menekan tombol dibawah ini',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Press the button',
            style: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 28.h,
          ),
          const SosButtonWidget(),
          SizedBox(
            height: 30.h,
          ),
          const CurrentUserLocationWidget(
            type: 'Lokasi Anda',
            alamat: 'Jl. Sambas no. 127 blok 87, Central Jakarta ',
            phone: '082123567789',
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20).w,
            child: Divider(
              thickness: 1,
              color: AppColor.dividerColor,
            ),
          )
        ],
      ),
    );
  }
}
