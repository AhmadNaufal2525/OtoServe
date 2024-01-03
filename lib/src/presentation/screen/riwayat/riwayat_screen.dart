import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:otoserve/src/presentation/screen/riwayat/widgets/card_transaksi_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({Key? key}) : super(key: key);

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  late Future<QuerySnapshot> paymentData;

  @override
  void initState() {
    super.initState();
    paymentData = loadPaymentData();
  }

  Future<QuerySnapshot> loadPaymentData() async {
    return FirebaseFirestore.instance.collection('payment').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Riwayat Transaksi',
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
          padding: const EdgeInsets.all(12.0).w,
          child: FutureBuilder<QuerySnapshot>(
            future: paymentData, // Use the future data
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading data'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No payment data available', style: TextStyle(color: Colors.white),),);
              } else {
                // Use the payment data to build your widgets
                final paymentDocs = snapshot.data!.docs;
                return Column(
                  children: paymentDocs.map((doc) {
                    final status = doc['paymentStatus'] as String;
                    final type = doc['serviceType'] as String;
                    final time = doc['paymentTime'] as String;
                    final orderId = doc['orderId'] as String;
                    final payment = doc['amount'] as String;
                    return CardTransaksiWidget(status: status, type: type, time: time, payment: payment, orderId: orderId,);
                  }).toList(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
