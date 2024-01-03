import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/homeService/widgets/mekanik_location_widget.dart';
import 'package:otoserve/src/presentation/screen/pembayaran/widgets/dashed_divider.dart';
import 'package:otoserve/src/presentation/screen/pembayaran/widgets/sucessfull_payment.dart';
import 'package:otoserve/src/utils/colors.dart';

class PembayaranHomeServiceScreen extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String? rate;
  final List<String> selectedServices;
  final List<String> selectedPrice;
  const PembayaranHomeServiceScreen(
      {Key? key,
      required this.name,
      required this.imageUrl,
      required this.selectedServices,
      required this.selectedPrice, this.rate})
      : super(key: key);

  @override
  State<PembayaranHomeServiceScreen> createState() =>
      _PembayaranHomeServiceScreenState();
}

class _PembayaranHomeServiceScreenState
    extends State<PembayaranHomeServiceScreen> {
  Future<void> addPaymentToFirestore() async {
    CollectionReference payments =
        FirebaseFirestore.instance.collection('payment');
    User? user = FirebaseAuth.instance.currentUser;
    String senderName = 'Unknown';

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('User')
          .doc(user.uid)
          .get();

      String? username = userData.data()?['username'];
      if (username != null && username.isNotEmpty) {
        senderName = username;
      }
    }

    await payments.add({
      'orderId': generateOrderId(),
      'paymentTime': getCurrentTime(),
      'paymentMethod': 'Bank Transfer',
      'service': widget.selectedServices.join(', '),
      'senderName': senderName,
      'amount': widget.selectedPrice.join(', '),
      'adminFee': 'Rp 1.000',
      'paymentStatus': 'Success',
      'serviceType': 'Home Service',
    });
  }

  String getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime =
        '${now.day}-${now.month}-${now.year}, ${now.hour}:${now.minute}:${now.second}';
    return formattedTime;
  }

  String generateOrderId() {
    const characters = '0123456789abcdefghijklmnopqrstuvwxyz';
    const length = 12;
    final random = Random();
    String orderId = '';
    for (int i = 0; i < length; i++) {
      orderId += characters[random.nextInt(characters.length)];
    }
    return orderId;
  }

  String totalPayment = '1.000.000';

  List<String> services = [
    'Service Mesin',
    'Ganti Oli',
    'Service AC',
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: AppColor.backgroundColor,
          appBar: AppBar(
            title: const Text(
              'Pembayaran',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MekanikLocationWidget(
                      nama: widget.name,
                      imageUrl: widget.imageUrl,
                      selectedServices: widget.selectedServices,
                      selectedPrice: widget.selectedPrice, rate: widget.rate!,
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0).w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/progress_4.png',
                  width: double.infinity,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Detail\nPembayaran',
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 32.h,
                ),
                Container(
                  width: 345.w,
                  height: 330.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColor.dividerColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0).w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Order Id',
                              style: TextStyle(color: Colors.white54),
                            ),
                            Text(
                              generateOrderId(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Payment Time',
                              style: TextStyle(color: Colors.white54),
                            ),
                            Text(
                              getCurrentTime(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Payment Method',
                              style: TextStyle(color: Colors.white54),
                            ),
                            Text(
                              'Bank Transfer',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Service',
                              style: TextStyle(color: Colors.white54),
                            ),
                            Text(
                              widget.selectedServices.join(', '),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sender Name',
                              style: TextStyle(color: Colors.white54),
                            ),
                            StreamBuilder<
                                DocumentSnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('User')
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<
                                          DocumentSnapshot<
                                              Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.hasData && snapshot.data!.exists) {
                                  var data = snapshot.data!.data();
                                  String? username = data?['username'];
                                  if (username!.isNotEmpty) {
                                    return Text(
                                      username.length > 12
                                          ? '${username.substring(0, 12)},'
                                          : username,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    );
                                  }
                                }
                                return const Text(
                                  "User",
                                  style: TextStyle(color: Colors.white),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const DashedDivider(
                          color: Colors.white38,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Amount',
                              style: TextStyle(color: Colors.white54),
                            ),
                            Text(
                              'Rp ${widget.selectedPrice.join(', ')}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Admin Fee',
                              style: TextStyle(color: Colors.white54),
                            ),
                            Text(
                              'Rp 1.000',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Payment Status',
                              style: TextStyle(color: Colors.white54),
                            ),
                            Container(
                              width: 70.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0.r),
                                color: const Color.fromARGB(
                                  111,
                                  255,
                                  241,
                                  118,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Pending',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.yellow,
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
                SizedBox(
                  height: 60.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    addPaymentToFirestore();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SucessfullPayment(),
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
                    'Bayar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
