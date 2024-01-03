import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/utils/colors.dart';

class CustomPasswordTextFieldWidget extends StatefulWidget {
  final FormFieldValidator<String>? validator;
  final ValueChanged<String> onChanged;
  final String? initialValue;
  final String label;
  final TextEditingController? controller;
  final bool isLoginScreen;

  const CustomPasswordTextFieldWidget(
      {super.key,
      this.validator,
      required this.onChanged,
      this.initialValue,
      this.controller,
      required this.label,
      required this.isLoginScreen});

  @override
  State<CustomPasswordTextFieldWidget> createState() =>
      _CustomPasswordTextFieldWidgetState();
}

class _CustomPasswordTextFieldWidgetState
    extends State<CustomPasswordTextFieldWidget> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isLoginScreen)
          Text(
            widget.label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        SizedBox(height: widget.isLoginScreen ? 10.h : 0),
        TextFormField(
          onChanged: widget.onChanged,
          controller: widget.controller,
          validator: widget.validator,
          obscureText: obscureText,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              errorStyle: const TextStyle(
                color: Colors.red,
              ),
              labelText: widget.isLoginScreen ? null : widget.label,
              hintText: widget.isLoginScreen ? widget.label : null,
              hintStyle: TextStyle(fontSize: 12.sp),
              contentPadding: EdgeInsets.symmetric(horizontal: 14.0.h),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
              ),
              filled: true,
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
