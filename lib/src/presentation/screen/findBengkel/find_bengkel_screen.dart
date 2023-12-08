import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/findBengkel/widgets/detail_bengkel_widget.dart';
import 'package:otoserve/src/presentation/screen/home/widgets/card_bengkel_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

class FindBengkelScreen extends StatefulWidget {
  const FindBengkelScreen({super.key});

  @override
  State<FindBengkelScreen> createState() => _FindBengkelScreenState();
}

class _FindBengkelScreenState extends State<FindBengkelScreen> {
  List<Map<String, dynamic>> bengkelData = [
    {
      'image': 'assets/images/bengkel.png',
      'text': 'Bengkel Tesla',
      'rate': '4.9',
      'jarak': '1.5 km',
      'status': 'Open',
    },
    {
      'image': 'assets/images/bengkel.png',
      'text': 'Bengkel Fusion',
      'rate': '4.7',
      'jarak': '2.2 km',
      'status': 'Closed',
    },
    {
      'image': 'assets/images/bengkel.png',
      'text': 'Bengkel Fusion',
      'rate': '4.7',
      'jarak': '2.2 km',
      'status': 'Closed',
    },
    {
      'image': 'assets/images/bengkel.png',
      'text': 'Bengkel Fusion',
      'rate': '4.7',
      'jarak': '2.2 km',
      'status': 'Closed',
    },
    {
      'image': 'assets/images/bengkel.png',
      'text': 'Bengkel Fusion',
      'rate': '4.7',
      'jarak': '2.2 km',
      'status': 'Closed',
    },
    {
      'image': 'assets/images/bengkel.png',
      'text': 'Bengkel Fusion',
      'rate': '4.7',
      'jarak': '2.2 km',
      'status': 'Closed',
    },
    {
      'image': 'assets/images/bengkel.png',
      'text': 'Bengkel Fusion',
      'rate': '4.7',
      'jarak': '2.2 km',
      'status': 'Closed',
    },
  ];

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
                'Find your nearest workshop',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Location',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        'Jl. Sambas no. 127 blok 87, Central Jakarta',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Nearest Workshop',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 480.h,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('bengkel')
                      .orderBy('jarak', descending: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    final docs = snapshot.data!.docs;
                    if (docs.isEmpty) {
                      return const Center(
                        child: Text('Bengkel tidak ditemuka'),
                      );
                    }
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10.h),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final bengkel = docs[index];
                        final List<String> services =
                            List<String>.from(bengkel['services'] ?? []);
                        return CardBengkelWidget(
                          image: bengkel['image_url'],
                          text: bengkel['nama'],
                          rate: bengkel['rate'],
                          jarak: bengkel['jarak'],
                          status: bengkel['status'],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailBengkelWidget(
                                  imageUrl: bengkel['image_url'],
                                  nama: bengkel['nama'],
                                  rate: bengkel['rate'],
                                  layanan: services,
                                  alamat: bengkel['alamat'],
                                  jamBuka: bengkel['jam'],
                                  status: bengkel['status'],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
