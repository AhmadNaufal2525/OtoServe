import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:otoserve/src/presentation/screen/auth/login_screen.dart';
import 'package:otoserve/src/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  Future<void> setLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> logout() async {
    await setLoggedIn(false);
    setState(
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen(),
          ),
          (route) => false,
        );
      },
    );
    await auth.signOut();
    await googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'My Account',
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                        String? email = data?['email'];
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
                                width: 22.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
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
                              SizedBox(
                                height: 10.h,
                              ),
                               Text(
                                email!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                ),
                              ),
                                ],
                              )
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
                  SizedBox(
                    height: 10.h,
                  ),
                  Divider(
                    thickness: 1,
                    color: AppColor.dividerColor,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/wallet.png',
                        width: 26.w,
                        height: 26.h,
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      Text(
                        'Saldo Anda',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(
                        width: 142.w,
                      ),
                      Text(
                        'Rp. 800.000',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Divider(
                    thickness: 1,
                    color: AppColor.dividerColor,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/point.png',
                        width: 26.w,
                        height: 26.h,
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      Text(
                        'OtoServe Points',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(
                        width: 102.w,
                      ),
                      Text(
                        '75.500 Points',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Divider(
                    thickness: 1,
                    color: AppColor.dividerColor,
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Text(
                    'Akun',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 6.w,
                      ),
                      Image.asset(
                        'assets/icons/edit.png',
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(
                        width: 33.w,
                      ),
                      Text(
                        'Edit Akun',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        width: 180.w,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: AppColor.dividerColor,
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 6.w,
                      ),
                      Image.asset(
                        'assets/icons/gift.png',
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(
                        width: 33.w,
                      ),
                      Text(
                        'Kode Voucher',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        width: 140.w,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 90.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () {
                        logout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.purpleColor,
                        minimumSize: Size(360.w, 50.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          side: BorderSide.none,
                        ),
                      ),
                      child: const Text('Sign Out', style: TextStyle(color: Colors.white,),),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
