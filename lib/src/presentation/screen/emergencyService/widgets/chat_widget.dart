import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/card_chat.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/user_chat_widget.dart';
import 'package:otoserve/src/utils/colors.dart';

class ChatWidget extends StatefulWidget {
  final String imageUrl;
  final String name;
  const ChatWidget({super.key, required this.imageUrl, required this.name});

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
        automaticallyImplyLeading: true,
         leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        toolbarHeight: 100.h,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: AppColor.dividerColor,
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
            SizedBox(
              width: 10.w,
            ),
            Text(
              widget.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardChat(
              name: widget.name,
              text: 'Halo, posisi sudah sesuai kan pak?',
              time: '29m',
              colorName: const Color(0xff00C4FF),
              colorContainer: const Color(0xffE0F8FF),
            ),
            const UserChatWidget(
              name: 'Saya',
              text: 'Sudah pak, sudah sesuai lokasi',
              time: '29m',
            ),
            CardChat(
              name: widget.name,
              text: 'Baik pak, mohon ditunggu kami\nsegera menuju lokasi',
              time: '30m',
              colorName: const Color(0xff00C4FF),
              colorContainer: const Color(0xffE0F8FF),
            ),
            const UserChatWidget(
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
                  width: 240,
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
