import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:otoserve/src/presentation/screen/auth/login_screen.dart';
import 'package:otoserve/src/presentation/screen/auth/widgets/custom_button_widget.dart';
import 'package:otoserve/src/presentation/screen/auth/widgets/custom_password_widget.dart';
import 'package:otoserve/src/presentation/screen/auth/widgets/custom_textfield_widget.dart';
import 'package:otoserve/src/utils/colors.dart';
import 'package:otoserve/src/widgets/bottom_navigation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  late String username;
  late String email;
  late String password;
  late String phoneNumber;
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  Future<void> setLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<void> registerUser(BuildContext context, String username, String email,
      String password) async {
    try {
      setState(() {
        isLoading = true;
      });

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      user?.updateDisplayName(username);
      String id = user?.uid ?? '';

      await firestore.collection('User').doc(user?.uid).set(
        {
          'id': id,
          'username': username,
          'email': email,
          'image': '',
          'nomor_telepon': phoneNumber
        },
      );

      setState(
        () {
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: "Daftar Akun Berhasil!",
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );

          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              ),
            ),
            isScrollControlled: true,
            builder: (context) {
              return const FractionallySizedBox(
                heightFactor: 0.862,
                child: LoginScreen(),
              );
            },
          );
        },
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: "Email sudah digunakan. Coba daftar dengan email lain.",
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: error.message.toString(),
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
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
      setState(() {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  const BottomNavigationWidget()),
          (route) => false,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      body: Stack(
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
                          'Create New Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                          ),
                        ),
                        Text(
                          'Please fill in the form to continue',
                          style: TextStyle(
                            color: AppColor.purpleColor,
                            fontSize: 11.sp,
                          ),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        Container(
                          height: 560.h,
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
                                      onChanged: (value) {
                                        username = value.trim();
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Username Tidak Boleh Kosong!';
                                        } else if (value.length < 8) {
                                          return 'Username harus terdiri dari 8 karakter!';
                                        }
                                        return null;
                                      },
                                      label: 'Fullname',
                                      isLoginScreen: false,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    CustomTextFieldWidget(
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
                                      label: 'Email',
                                      isLoginScreen: false,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    CustomTextFieldWidget(
                                      onChanged: (value) {
                                        phoneNumber = value.trim();
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Nomor Tidak Boleh Kosong!';
                                        } else if (value.length < 10) {
                                          return 'Nomor harus terdiri dari 10 karakter!';
                                        }
                                        return null;
                                      },
                                      label: 'Phone Number',
                                      isLoginScreen: false,
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
                                          return 'Password Tidak Boleh Kosong!';
                                        } else if (value.length < 6) {
                                          return 'Password harus terdiri dari 6 karakter atau lebih';
                                        }
                                        return null;
                                      },
                                      label: 'Password',
                                      isLoginScreen: false,
                                    ),
                                    SizedBox(
                                      height: 43.h,
                                    ),
                                    CustomButtonWidget(
                                      text: 'Sign Up',
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          registerUser(
                                              context, username, email, password);
                                        }
                                      },
                                      buttonColor: AppColor.purpleColor,
                                      textColor: Colors.white,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    CustomButtonWidget(
                                      text: 'Sign Up with Google',
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
                                      text: 'Sign Up with Apple',
                                      onPressed: () {},
                                      icon: Image.asset(
                                        'assets/icons/apple.png',
                                        width: 20.w,
                                        height: 20.h,
                                      ),
                                      buttonColor: AppColor.textfieldColor,
                                      textColor: Colors.white,
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
                              "Have an account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign In',
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
