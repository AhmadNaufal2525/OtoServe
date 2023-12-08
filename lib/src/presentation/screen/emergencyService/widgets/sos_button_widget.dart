import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/waiting_emergency_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

class SosButtonWidget extends StatelessWidget {
  const SosButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 150,
      backgroundColor: AppColor.dividerColor,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const WaitingEmergencyWidget(),
            ),
          );
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
            (Set<MaterialState> states) {
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(150.0),
              );
            },
          ),
          minimumSize: MaterialStateProperty.resolveWith<Size?>(
            (Set<MaterialState> states) {
              return const Size(218, 218);
            },
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.redAccent;
              }
              return Colors.redAccent;
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey;
              }
              return const Color(0xffD5D5D5);
            },
          ),
        ),
        child: Text(
          'SOS',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 80.0.sp,
          ),
        ),
      ),
    );
  }
}
