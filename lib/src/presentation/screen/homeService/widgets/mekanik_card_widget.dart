import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/homeService/widgets/konsultasi_chat_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

class MekanikCardWidget extends StatelessWidget {
  final Function() onPressed;
  final String imageUrl;
  final String name;
  final String experience;
  final String spesialist;
  final String rate;
  final String job;
  const MekanikCardWidget({
    Key? key,
    required this.name,
    required this.job,
    required this.imageUrl,
    required this.spesialist,
    required this.rate,
    required this.onPressed,
    required this.experience,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: 386.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0.r),
        color: AppColor.dividerColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 30.h,
              width: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0.r),
                  topRight: Radius.circular(10.0.r),
                ),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(rate)
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        name,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        spesialist,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 30.h,
                            width: 110.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 10.w,
                                ),
                                const Icon(
                                  CupertinoIcons.briefcase_fill,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 6.w,
                                ),
                                Text(
                                  experience,
                                  style: TextStyle(fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KonsultasiChatWidget(
                                  name: name, imageUrl: imageUrl, rate: rate,
                                ),
                              ),
                            );
                            },
                            child: Container(
                              height: 30.h,
                              width: 110.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    'Chat Sekarang',
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
