import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/findBengkel/widgets/detail_bengkel_widget.dart';
import 'package:otoserve/src/presentation/screen/home/widgets/promo_widget.dart';
import 'package:otoserve/src/presentation/screen/home/widgets/service_widget.dart';
import 'package:otoserve/src/presentation/screen/home/widgets/card_bengkel_widget.dart';
import 'package:otoserve/src/presentation/screen/home/widgets/wallet_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              toolbarHeight: 80.h,
              centerTitle: false,
              title: Row(
                children: [
                  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('User')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.hasData && snapshot.data!.exists) {
                        var data = snapshot.data!.data();
                        String? username = data?['username'];
                        String? image = data?['image'];
                        if (username != null && username.isNotEmpty) {
                          return Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                  image!,
                                ),
                                onBackgroundImageError: (exception, stackTrace) {
                                  const NetworkImage('https://cdn3.iconfinder.com/data/icons/login-5/512/LOGIN_6-1024.png');
                                },
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Text(
                                username.length > 12
                                    ? '${username.substring(0, 12)},'
                                    : username,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          );
                        }
                      }
                      return const Text(
                        "User",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18.8,
                        ),
                      );
                    },
                  ),
                ],
              ),
              actions: [
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
            backgroundColor: AppColor.backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  const WalletWidget(),
                  SizedBox(
                    height: 30.h,
                  ),
                  const ServiceWidget(),
                  SizedBox(
                    height: 28.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20).w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PromoWidget(),
                        SizedBox(
                          height: 18.h,
                        ),
                        Text(
                          'Top Bengkel',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),
                        SizedBox(
                          height: 120,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('bengkel')
                                .orderBy('rate', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
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
                              return ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  final bengkel = docs[index];
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
                                          builder: (context) =>
                                              DetailBengkelWidget(
                                            imageUrl: bengkel['image_url'],
                                            nama: bengkel['nama'],
                                            rate: bengkel['rate'],
                                            layanan: bengkel['services'],
                                            alamat: bengkel['alamat'],
                                            jamBuka: bengkel['jam'],
                                            status: bengkel['status'], jarak: bengkel['jarak'],
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
                        Divider(
                          thickness: 1,
                          color: AppColor.dividerColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
