import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/bengkel_emergency_widget.dart';
import 'package:otoserve/src/presentation/screen/home/home_screen.dart';
import 'package:otoserve/src/utils/colors.dart';

class PembayaranScreen extends StatefulWidget {
  const PembayaranScreen({Key? key}) : super(key: key);

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  String selectedPaymentMethod = 'Credit Card';
  String totalPayment = '1.000.000';

  List<String> services = [
    'Towing',
    'Ganti Suku Cadang',
    'Tune Up Mesin',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: const Text('Payment'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const BengkelEmergencyWidget(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0).w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: LottieBuilder.network(
                'https://lottie.host/a5bde4eb-8188-4c19-ba36-74935a6e6e71/62WzDqBwX6.json',
                width: 280.w,
                height: 280.h,
              ),
            ),
            const Text(
              'Pilih Metode Pembayaran:',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            DropdownButton<String>(
              value: selectedPaymentMethod,
              onChanged: (String? newValue) {
                setState(() {
                  selectedPaymentMethod = newValue!;
                });
              },
              dropdownColor: Colors.black,
              items: <String>['Credit Card', 'PayPal', 'Bank Transfer', 'Cash']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Service:',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: services.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading:
                        const Icon(Icons.check_outlined, color: Colors.green),
                    title: Text(
                      services[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Total Payment: Rp $totalPayment',
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24.0.h),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.saldoColor,
                  minimumSize: Size(280.w, 50.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    side: BorderSide.none,
                  ),
                ),
                child: const Text('Bayar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
