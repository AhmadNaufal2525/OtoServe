import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/homeService/widgets/konsultasi_chat_widget.dart';
import 'package:otoserve/src/presentation/screen/pembayaran/pembayaran_home_service.dart';
import 'package:otoserve/src/utils/colors.dart';

class MekanikLocationWidget extends StatefulWidget {
  final String nama;
  final String imageUrl;
  final String rate;
  final List<String> selectedServices;
  final List<String> selectedPrice;

  const MekanikLocationWidget(
      {Key? key, required this.nama, required this.imageUrl, required this.selectedServices, required this.selectedPrice, required this.rate, })
      : super(key: key);

  @override
  State<MekanikLocationWidget> createState() => _MekanikLocationWidgetState();
}

class _MekanikLocationWidgetState extends State<MekanikLocationWidget> {
  late String currentImageMaps = 'assets/images/maps_1.png';
  late String currentProgress = 'assets/images/progress_2.png';
  late String currentText = 'Tiba dalam 10 menit';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      setState(() {
        currentImageMaps = 'assets/images/maps_2.png';
        currentProgress = 'assets/images/progress_3.png';
        currentText = 'Mekanik sudah sampai tujuan';
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              currentImageMaps,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 18),
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
              padding: const EdgeInsets.only(top: 470.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 380.h,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(50),
                      ),
                      color: AppColor.containerColor,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(18.0.w),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0).r,
                                child: Image.network(
                                  widget.imageUrl,
                                  width: 80.w,
                                  height: 100.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 12.w),
                                      Text(
                                        widget.nama,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    children: [
                                      SizedBox(width: 8.w),
                                      const Icon(
                                        Icons.time_to_leave_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        currentText,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                      SizedBox(width: 40.w),
                                    ],
                                  ),
                                  SizedBox(height: 14.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(width: 10.w),
                                      Container(
                                        height: 30.h,
                                        width: 60.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.r),
                                          ),
                                          color: const Color(0xff2C8B5D),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              widget.rate,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20.w),
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      KonsultasiChatWidget(
                                                    name: widget.nama,
                                                    imageUrl: widget.imageUrl,
                                                    konfirm: true, rate: widget.rate,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Icon(
                                              Icons.chat_rounded,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Positioned(
                                            top: -2,
                                            right: -3,
                                            child: CircleAvatar(
                                              radius: 5.r,
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          Column(
                            children: [
                              Image.asset(
                                currentProgress,
                                width: double.infinity,
                              ),
                              SizedBox(height: 30.h),
                              Container(
                                width: 373.w,
                                height: 3.h,
                                color: const Color(0xff777777),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Biaya ${widget.selectedServices.join(', ')}',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                     'Rp ${widget.selectedPrice.join(', ')}',
                                    style: const TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(height: 10.h),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Saldo Anda',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    'Rp 250.000',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(height: 30.h),
                              Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PembayaranHomeServiceScreen(
                                          name: widget.nama,
                                          imageUrl: widget.imageUrl, selectedServices: widget.selectedServices, selectedPrice: widget.selectedPrice, rate: widget.rate,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.purpleColor,
                                    minimumSize: Size(360.w, 50.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                      side: BorderSide.none,
                                    ),
                                  ),
                                  child: const Text(
                                    'Bayar',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
