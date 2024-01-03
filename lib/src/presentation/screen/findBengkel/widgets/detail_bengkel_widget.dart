import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/findBengkel/widgets/card_review_widget.dart';
import 'package:otoserve/src/presentation/screen/findBengkel/widgets/navigasi_bengkel_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

class DetailBengkelWidget extends StatefulWidget {
  final String imageUrl;
  final String nama;
  final String rate;
  final String alamat;
  final String jamBuka;
  final String status;
  final String jarak;
  final List<dynamic> layanan;
  const DetailBengkelWidget({
    super.key,
    required this.imageUrl,
    required this.nama,
    required this.rate,
    required this.layanan,
    required this.alamat,
    required this.jamBuka,
    required this.status, required this.jarak,
  });

  @override
  State<DetailBengkelWidget> createState() => _DetailBengkelWidgetState();
}

class _DetailBengkelWidgetState extends State<DetailBengkelWidget> {
  late List<dynamic> layanan;
  double rating = 0;

  @override
  void initState() {
    layanan = widget.layanan;
    rating = double.tryParse(widget.rate)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int halfLength = (widget.layanan.length / 2).ceil();
    final List<dynamic> leftList = widget.layanan.take(halfLength).toList();
    final List<dynamic> rightList = widget.layanan.skip(halfLength).toList();
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.network(
              widget.imageUrl,
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
              padding: const EdgeInsets.only(top: 280.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 660.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          topRight: Radius.circular(15.r),
                        ),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Text(
                            widget.nama,
                            style: TextStyle(
                                fontSize: 22.sp, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 10.0.h),
                          RatingBar.builder(
                            initialRating: rating,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 30.0,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            ignoreGestures: true,
                            onRatingUpdate: (double value) {},
                          ),
                          SizedBox(height: 20.0.h),
                          Text(
                            'Layanan Service',
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w800),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: leftList.map((service) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 18.0,
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            service.toString(),
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(
                                width: 80.w,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: rightList.map((service) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 18.0,
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            service.toString(),
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            'Jam Buka',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            widget.jamBuka,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            'Alamat',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.alamat,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xff7A7E86),
                                ),
                              ),
                              const CircleAvatar(
                                backgroundColor: Color(0xffF6F7F8),
                                child: Icon(
                                  Icons.location_on,
                                  color: Color(0xff989BA1),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            'Ulasan',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 15.h),
                          const CardReviewWidget(
                            imageUrl:
                                'https://cdn3.iconfinder.com/data/icons/login-5/512/LOGIN_6-1024.png',
                            username: 'Kurionin',
                            comments:
                                'Bengkelnya bersih, rapih, pengerjaanya cepat dan mekanik nya cepat tanggap. pokoknya rekomendasi banget buat bengkel ini',
                            timeUpload: '03-10-2023',
                            rating: 4.3,
                          ),
                          SizedBox(height: 18.h),
                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NavigasiBengkelWidget(
                                      nama: widget.nama, imageUrl: widget.imageUrl, rating: widget.rate, jarak: widget.jarak, status: widget.status
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff1E1E1E),
                                minimumSize: Size(360.w, 50.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  side: BorderSide.none,
                                ),
                              ),
                              child: const Text(
                                'Navigasi Bengkel',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
