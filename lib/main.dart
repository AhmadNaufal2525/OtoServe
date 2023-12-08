import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otoserve/src/presentation/router/routes.dart';
import 'package:otoserve/src/presentation/screen/auth/splash_screen.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/emergency_service_screen.dart';
import 'package:otoserve/src/presentation/screen/findBengkel/find_bengkel_screen.dart';
import 'package:otoserve/src/presentation/screen/home/home_screen.dart';
import 'package:otoserve/src/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBZBZRKmY0qTpoatnZYx8z6IjnoCQzwYvY",
      authDomain: "otoserve-49e20.firebaseapp.com",
      projectId: "otoserve-49e20",
      storageBucket: "otoserve-49e20.appspot.com",
      messagingSenderId: "931096297493",
      appId: "1:931096297493:web:5bad15f45b0d987eab0e1c",
      measurementId: "G-N03ZTW403E",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OtoServe',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: AppColor.primaryColor, centerTitle: true, elevation: 0),
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        initialRoute: '/',
        routes: {
          Routes.splashScreen: (context) => const SplashScreen(),
          Routes.homeScreen: (context) => const HomeScreen(),
          Routes.emergencyServiceScreen: (context) =>
              const EmergencyServiceScreen(),
          Routes.findBengkelScreen: (context) => const FindBengkelScreen(),
        },
      ),
      designSize: const Size(414, 736),
    );
  }
}
