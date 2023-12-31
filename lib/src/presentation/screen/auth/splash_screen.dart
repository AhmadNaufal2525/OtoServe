import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/auth/login_screen.dart';
import 'package:otoserve/src/utils/colors.dart';
import 'package:otoserve/src/widgets/bottom_navigation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    openSplashScreen();
  }

   openSplashScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    var durasiSplash = const Duration(seconds: 2);
    return Timer(
      durasiSplash,
      () async {
        if (isLoggedIn) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) {
                return const BottomNavigationWidget();
              },
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) {
                return const LoginScreen();
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 102.w,
                  height: 100.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
