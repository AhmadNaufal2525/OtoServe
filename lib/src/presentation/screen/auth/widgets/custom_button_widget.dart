import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color? textColor;
  final Widget? icon;
  final Color buttonColor;

  const CustomButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.icon, required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(280.w, 50.h),
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
          side: BorderSide.none,
        ),
      ),
      label: Text(
        text,
        style: TextStyle(
            color: textColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
      ),
      icon: icon != null ? icon! : const SizedBox(),
    );
  }
}