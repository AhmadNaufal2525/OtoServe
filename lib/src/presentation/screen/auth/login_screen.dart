import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:otoserve/src/presentation/screen/auth/register_screen.dart';
import 'package:otoserve/src/presentation/screen/auth/widgets/custom_button_widget.dart';
import 'package:otoserve/src/presentation/screen/auth/widgets/custom_password_widget.dart';
import 'package:otoserve/src/presentation/screen/auth/widgets/custom_textfield_widget.dart';
import 'package:otoserve/src/utils/colors.dart';
import 'package:otoserve/src/widgets/bottom_navigation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late String email;
  late String password;
  final auth = FirebaseAuth.instance;
  bool isLoading = false;
  Future<void> setLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> signin(
      BuildContext context, String email, String password) async {
    try {
      setState(() {
        isLoading = true;
      });
      await auth.signInWithEmailAndPassword(email: email, password: password);
      setState(
        () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const BottomNavigationWidget(),
            ),
            (route) => false,
          );
        },
      );
      await setLoggedIn(true);
    } on FirebaseAuthException catch (error) {
      Fluttertoast.showToast(
          msg: error.message.toString(),
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      setState(() {
        isLoading = true;
      });

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null) {
        final userRef = FirebaseFirestore.instance.collection('User');
        final existingUser = await userRef.doc(user.uid).get();
        if (!existingUser.exists) {
          await userRef.doc(user.uid).set({
            'id': user.uid,
            'username': user.displayName ?? '',
            'email': user.email ?? '',
            'image': user.photoURL ?? '',
            'nomor_telepon': user.phoneNumber ?? '',
          });
        }
      }
      await setLoggedIn(true);
      setState(() {
        isLoading = false;
      });
      return userCredential;
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      return null;
    }
  }

  checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      setState(
        () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const BottomNavigationWidget(),
            ),
            (route) => false,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
        children: [
          SizedBox(
            height: 161.h,
            child: Image.asset(
              'assets/images/circle.png',
              fit: BoxFit.contain,
            ),
          ),
          Stack(
            children: [
              Opacity(
                opacity: isLoading ? 0.5 : 1.0,
                child: AbsorbPointer(
                  absorbing: isLoading,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 74.h,
                            ),
                            Text(
                              'Welcome Back',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                              ),
                            ),
                            Text(
                              'Please sign in to your account',
                              style: TextStyle(
                                color: AppColor.purpleColor,
                                fontSize: 11.sp,
                              ),
                            ),
                            SizedBox(
                              height: 22.h,
                            ),
                            Container(
                              height: 530.h,
                              width: 330.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0).r,
                                color: AppColor.containerColor,
                              ),
                              child: Form(
                                key: formKey,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(22.0).w,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        CustomTextFieldWidget(
                                          label: 'Email',
                                          isLoginScreen: true,
                                          onChanged: (value) {
                                            email = value.trim();
                                          },
                                          validator: (value) {
                                            final emailRegex = RegExp(
                                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                            if (value == null || value.isEmpty) {
                                              return 'Email Tidak Boleh Kosong!';
                                            } else if (!emailRegex.hasMatch(value)) {
                                              return 'Masukkan Alamat Email Dengan Benar!';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        CustomPasswordTextFieldWidget(
                                          onChanged: (value) {
                                            password = value.trim();
                                          },
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Masukkan Password Anda';
                                            } else if (value.length < 6) {
                                              return 'Password harus terdiri dari 6 karakter!';
                                            }
                                            return null;
                                          },
                                          label: 'Password',
                                          isLoginScreen: true,
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'Forgot Password?',
                                              style: TextStyle(
                                                color: Colors.white60,
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        CustomButtonWidget(
                                          text: 'Sign In',
                                          onPressed: () {
                                            if (formKey.currentState!.validate()) {
                                              signin(context, email, password);
                                            }
                                          },
                                          buttonColor: AppColor.purpleColor,
                                          textColor: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        CustomButtonWidget(
                                          text: 'Sign In with Google',
                                          textColor: AppColor.dividerColor,
                                          onPressed: () {
                                            signInWithGoogle().then(
                                              (userCredential) {
                                                if (userCredential != null) {
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) =>
                                                          const BottomNavigationWidget(),
                                                    ),
                                                    (route) => false,
                                                  );
                                                } else {
                                                  Navigator.pop(context);
                                                }
                                              },
                                            );
                                          },
                                          icon: Image.asset(
                                            'assets/icons/google.png',
                                            width: 20.w,
                                            height: 20.h,
                                          ),
                                          buttonColor: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 20.h,
                                        ),
                                        CustomButtonWidget(
                                          text: 'Sign In with Apple',
                                          onPressed: () {},
                                          icon: Image.asset(
                                            'assets/icons/apple.png',
                                            width: 20.w,
                                            height: 20.h,
                                          ),
                                          textColor: Colors.white,
                                          buttonColor: AppColor.textfieldColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have account?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: AppColor.purpleColor,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: SpinKitWave(
                  color: AppColor.dividerColor,
                  size: 50.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
