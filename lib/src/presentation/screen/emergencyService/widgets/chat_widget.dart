import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/card_chat.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/user_chat_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: false,
        toolbarHeight: 100.h,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chat Bengkel',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColor.dividerColor,
                  child: Icon(
                    Icons.person_2_rounded,
                    size: 20.sp,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'Montir Agus',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
        elevation: 0,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CardChat(
              name: 'Montir Agus',
              text: 'Halo, posisi sudah sesuai kan pak?',
              time: '29m',
              colorName: Color(0xff00C4FF),
              colorContainer: Color(0xffE0F8FF),
            ),
            UserChatWidget(
              name: 'Saya',
              text: 'Sudah pak, sudah sesuai lokasi',
              time: '29m',
            ),
            CardChat(
              name: 'Montir Agus',
              text: 'Baik pak, mohon ditunggu kami\nsegera menuju lokasi',
              time: '30m',
              colorName: Color(0xff00C4FF),
              colorContainer: Color(0xffE0F8FF),
            ),
            UserChatWidget(
              name: 'Saya',
              text: 'Oke pak ditunggu ya pak',
              time: '29m',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(
          0.0,
          -1 * mediaQueryData.viewInsets.bottom,
        ),
        child: BottomAppBar(
          color: AppColor.primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: Color(0xffF6F6F6),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_on_rounded,
                      color: AppColor.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 272,
                  child: TextFormField(
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: 'Ketuk untuk menulis...',
                      hintStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 16.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: const Color(0xffF6F6F6),
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: AppColor.primaryColor,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
