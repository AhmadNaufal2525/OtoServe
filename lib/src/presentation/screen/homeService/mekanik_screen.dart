import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/homeService/home_service_screen.dart';
import 'package:otoserve/src/presentation/screen/homeService/widgets/konsultasi_chat_widget.dart';
import 'package:otoserve/src/presentation/screen/homeService/widgets/mekanik_card_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

class MekanikScreen extends StatefulWidget {
  final String name;
  const MekanikScreen({super.key, required this.name});

  @override
  State<MekanikScreen> createState() => _MekanikScreenState();
}

class _MekanikScreenState extends State<MekanikScreen> {
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
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeServiceScreen(),
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
          'Mekanik ${widget.name}',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0).w,
        child: SizedBox(
          height: double.infinity,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('mekanik')
                .orderBy('rate', descending: false)
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
                  child: Text('Mekanik tidak ditemukan', style: TextStyle(color: Colors.white),),
                );
              }
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(height: 20.h),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final mekanik = docs[index];
                  return MekanikCardWidget(
                    name: mekanik['nama'],
                    job: mekanik['job'],
                    imageUrl: mekanik['image_url'],
                    spesialist: mekanik['spesialist'],
                    experience: mekanik['experience'],
                    rate: mekanik['rate'],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KonsultasiChatWidget(
                            name: mekanik['nama'],
                            imageUrl: mekanik['image_url'],
                            rate: mekanik['rate'],
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
      ),
    );
  }
}
