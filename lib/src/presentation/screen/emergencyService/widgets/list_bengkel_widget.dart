import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/emergency_service_screen.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/bengkel_emergency_widget.dart';
import 'package:otoserve/src/presentation/screen/home/widgets/card_bengkel_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

class ListBengkelWidget extends StatefulWidget {
  final String namaLayanan;
  final String harga;
  const ListBengkelWidget({super.key, required this.namaLayanan, required this.harga});

  @override
  State<ListBengkelWidget> createState() => _ListBengkelWidgetState();
}

class _ListBengkelWidgetState extends State<ListBengkelWidget> {
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
         leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const EmergencyServiceScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: true,
        centerTitle: false,
        toolbarHeight: 80.h,
        title: Text(
          'Pilih bengkel',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
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
                        'Lokasi Anda',
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
                'Bengkel Terdekat',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(
                height: 16.h,
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
                        child: Text('Bengkel tidak ditemukan'),
                      );
                    }
                    return ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) =>
                        SizedBox(height: 30.h),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final bengkel = docs[index];
                        return CardBengkelWidget(
                          image: bengkel['image_url'],
                          text: bengkel['nama'],
                          rate: bengkel['rate'],
                          jarak: bengkel['jarak'],
                          status: bengkel['status'],
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BengkelEmergencyWidget(namaLayanan: widget.namaLayanan, harga: widget.harga,),
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
