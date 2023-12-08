import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/chat_widget.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/current_user_location_widget.dart';
import 'package:otoserve/src/presentation/screen/pembayaran/pembayaran_screen.dart';
import 'package:otoserve/src/utils/colors.dart';

class BengkelEmergencyWidget extends StatelessWidget {
  const BengkelEmergencyWidget({super.key});

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
                'Bengkel Ditemukan',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 22.sp,
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
            height: 16.h,
          ),
          Image.asset(
            'assets/images/maps.jpeg',
            width: double.infinity,
            height: 220.h,
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 30.h,
          ),
          Center(
            child: Text(
              'LOKASI BENGKEL',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Bengkel akan segera menuju lokasi',
            style: TextStyle(
              color: Colors.grey[400],
              fontWeight: FontWeight.w700,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30.h,
          ),
          const CurrentUserLocationWidget(
            type: 'Lokasi Bengkel',
            alamat: 'Jl. Sambas no. 127 blok 87, Central Jakarta ',
            phone: '082123567789',
          ),
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChatWidget(),
                    ),
                  );
                },
                icon: const Icon(Icons.chat_rounded),
                label: const Text('Chat Bengkel'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.saldoColor,
                  minimumSize: Size(100.w, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    side: BorderSide.none,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PembayaranScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(160.w, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    side: BorderSide.none,
                  ),
                ),
                child: Text(
                  'Selesai',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
            ],
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
