import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/homeService/widgets/custom_checkbox_widget.dart';
import 'package:otoserve/src/presentation/screen/homeService/widgets/mekanik_location_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

class HomeServiceList extends StatefulWidget {
  final String nama;
  final String imageUrl;
  final String rate;
  const HomeServiceList(
      {super.key,
      required this.nama,
      required this.imageUrl,
      required this.rate});

  @override
  State<HomeServiceList> createState() => _HomeServiceListState();
}

class _HomeServiceListState extends State<HomeServiceList> {
  late Stream<QuerySnapshot> serviceStream;
  Map<String, bool> serviceValues = {};
  Map<String, String> servicePrices = {};

  @override
  void initState() {
    super.initState();
    serviceStream =
        FirebaseFirestore.instance.collection('service').snapshots();
  }

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
        elevation: 0,
        title: const Text(
          'Pilih Service',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      backgroundColor: AppColor.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/progress_1.png',
              height: 100,
              width: double.infinity,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: serviceStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                final List<QueryDocumentSnapshot> documents =
                    snapshot.data!.docs;

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: documents.map((DocumentSnapshot document) {
                      final Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      final String serviceName = data['name'] ?? '';
                      final String servicePrice = data['price'] ?? '';
                      servicePrices[serviceName] = servicePrice;
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Container(
                          width: 348.w,
                          height: 73.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 10.w),
                              CustomCheckboxWidget(
                                value: serviceValues[serviceName] ?? false,
                                onChanged: (value) {
                                  setState(() {
                                    serviceValues[serviceName] = value;
                                  });
                                },
                              ),
                              SizedBox(width: 10.w),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0.w, vertical: 10.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(serviceName),
                                    SizedBox(height: 8.h),
                                    Text(servicePrice),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                List<String> selectedServices = serviceValues.entries
                    .where((entry) => entry.value)
                    .map((entry) => entry.key)
                    .toList();

                List<String> selectedPrices =
                    selectedServices.map((serviceName) {
                  return servicePrices[serviceName] ?? '';
                }).toList();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MekanikLocationWidget(
                        nama: widget.nama,
                        imageUrl: widget.imageUrl,
                        selectedServices: selectedServices,
                        selectedPrice: selectedPrices,
                        rate: widget.rate),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.purpleColor,
                minimumSize: Size(345.w, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  side: BorderSide.none,
                ),
              ),
              child: const Text(
                'Pesan',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
