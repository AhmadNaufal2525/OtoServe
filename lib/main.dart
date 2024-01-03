import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otoserve/firebase_options.dart';
import 'package:otoserve/src/presentation/router/routes.dart';
import 'package:otoserve/src/presentation/screen/auth/splash_screen.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/emergency_service_screen.dart';
import 'package:otoserve/src/presentation/screen/findBengkel/find_bengkel_screen.dart';
import 'package:otoserve/src/presentation/screen/home/home_screen.dart';
import 'package:otoserve/src/presentation/screen/homeService/home_service_screen.dart';
import 'package:otoserve/src/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
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
            color: AppColor.primaryColor,
            centerTitle: true,
            elevation: 0,
          ),
          fontFamily: GoogleFonts.poppins().fontFamily,
        ),
        initialRoute: '/',
        routes: {
          Routes.splashScreen: (context) => const SplashScreen(),
          Routes.homeScreen: (context) => const HomeScreen(),
          Routes.emergencyServiceScreen: (context) =>
              const EmergencyServiceScreen(),
          Routes.findBengkelScreen: (context) => const FindBengkelScreen(),
          Routes.homeServiceScreen: (context) => const HomeServiceScreen()
        },
      ),
      designSize: const Size(392, 852),
    );
  }
}
