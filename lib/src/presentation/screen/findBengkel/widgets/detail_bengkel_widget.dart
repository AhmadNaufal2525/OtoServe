import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/findBengkel/widgets/navigasi_bengkel_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

class DetailBengkelWidget extends StatefulWidget {
  final String imageUrl;
  final String nama;
  final String rate;
  final String alamat;
  final String jamBuka;
  final String status;
  final List<dynamic> layanan;
  const DetailBengkelWidget({
    super.key,
    required this.imageUrl,
    required this.nama,
    required this.rate,
    required this.layanan,
    required this.alamat,
    required this.jamBuka,
    required this.status,
  });

  @override
  State<DetailBengkelWidget> createState() => _DetailBengkelWidgetState();
}

class _DetailBengkelWidgetState extends State<DetailBengkelWidget> {
  late List<dynamic> layanan;
  @override
  void initState() {
    layanan = widget.layanan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int halfLength = (widget.layanan.length / 2).ceil();
    final List<dynamic> leftList = widget.layanan.take(halfLength).toList();
    final List<dynamic> rightList = widget.layanan.skip(halfLength).toList();
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              expandedHeight: MediaQuery.of(context).size.height * 0.45,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        widget.imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    width: double.infinity,
                    height: 380.h,
                    padding: const EdgeInsets.all(20.0).w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.r),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.nama,
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  size: 20,
                                  color: Colors.yellow[600],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              widget.rate,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 30.sp,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              widget.alamat,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Layanan Service :',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 8.h),
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
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: rightList.map((service) {
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
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Jam Buka:',
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
                        SizedBox(height: 10.h),
                        Text(
                          widget.status,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            color:
                                widget.status.toLowerCase() == 'buka sekarang'
                                    ? Colors.green
                                    : Colors.red,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NavigasiBengkelWidget(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              minimumSize: Size(280.w, 40.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                side: BorderSide.none,
                              ),
                            ),
                            child: const Text('Navigasi Bengkel'),
                          ),
                        )
                      ],
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
