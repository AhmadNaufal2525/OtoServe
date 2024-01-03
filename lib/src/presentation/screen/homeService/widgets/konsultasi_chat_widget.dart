import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/card_chat.dart';
import 'package:otoserve/src/presentation/screen/emergencyService/widgets/user_chat_widget.dart';
import 'package:otoserve/src/presentation/screen/homeService/home_service_list.dart';
import 'package:otoserve/src/utils/colors.dart';

class KonsultasiChatWidget extends StatefulWidget {
  final String name;
  final String imageUrl;
  final bool? konfirm;
  final String? rate;
  const KonsultasiChatWidget(
      {super.key,
      required this.name,
      required this.imageUrl,
      this.konfirm,
      this.rate});

  @override
  State<KonsultasiChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<KonsultasiChatWidget> {
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
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: AppColor.dividerColor,
              backgroundImage: NetworkImage(widget.imageUrl),
              onBackgroundImageError: (exception, stackTrace) {
                Icon(
                  Icons.person_2_rounded,
                  size: 20.sp,
                  color: Colors.white,
                );
              },
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
        actions: widget.konfirm == true
            ? null // If konfirm is true, don't show any action buttons
            : [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeServiceList(
                          nama: widget.name,
                          imageUrl: widget.imageUrl,
                          rate: widget.rate!
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Selesai',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
        elevation: 0,
      ),
      backgroundColor: AppColor.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardChat(
              name: widget.name,
              text: 'Halo, Apa yang ini anda diskusikan?',
              time: '2m',
              colorName: const Color(0xff00C4FF),
              colorContainer: const Color(0xffE0F8FF),
            ),
            const UserChatWidget(
              name: 'Saya',
              text:
                  'Mesin mobil saya berbunyi dengan keras,\napa yang harus di service?',
              time: '1m',
            ),
            CardChat(
              name: widget.name,
              text:
                  'Silahkan anda memilih service\nmesin untuk memperbaiki mesin mobil anda',
              time: '1m',
              colorName: const Color(0xff00C4FF),
              colorContainer: const Color(0xffE0F8FF),
            ),
            const UserChatWidget(
              name: 'Saya',
              text: 'Oke saya akan memesan service mesin',
              time: '1m',
            ),
            CardChat(
              name: widget.name,
              text: 'Baik, silahkan lakukan pemesanan home service',
              time: '5s',
              colorName: const Color(0xff00C4FF),
              colorContainer: const Color(0xffE0F8FF),
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
                  width: 240.w,
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
