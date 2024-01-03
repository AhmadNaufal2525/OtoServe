import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/utils/colors.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;
  final String label;
  final String? initialValue;
  final TextEditingController? controller;
  final bool isLoginScreen;
  const CustomTextFieldWidget({
    super.key,
    required this.onChanged,
    this.validator,
    this.initialValue,
    this.controller,
    required this.label,
    required this.isLoginScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isLoginScreen)
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        SizedBox(height: isLoginScreen ? 10.h : 0),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          controller: controller,
          validator: validator,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              labelText: isLoginScreen ? null : label,
              hintText: isLoginScreen ? label : null,
              hintStyle: TextStyle(fontSize: 12.sp),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14.0 ).h,
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColor.textfieldColor, width: 2),
                borderRadius: BorderRadius.circular(5.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: AppColor.textfieldColor, width: 1.5),
                borderRadius: BorderRadius.circular(5.r),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(5.r),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(5.r),
              ),
              fillColor: AppColor.textfieldColor),
        ),
      ],
    );
  }
}
