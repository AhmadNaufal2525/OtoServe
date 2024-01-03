import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/list_bengkel_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

import 'card_layanan_widget.dart';

class LayananBengkelWidget extends StatelessWidget {
  const LayananBengkelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
          'Pilih Layanan',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: SizedBox(
        height: 800.h,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('layanan').snapshots(),
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
              separatorBuilder: (context, index) => SizedBox(height: 10.h),
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final layanan = docs[index];
                return CardLayananWidget(
                  image: layanan['image_url'],
                  text: layanan['nama'],
                  price: layanan['price'],
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListBengkelWidget(namaLayanan: layanan['nama'], harga: layanan['price'],

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
    );
  }
}
