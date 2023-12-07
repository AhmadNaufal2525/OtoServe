import 'package:flutter/material.dart';
import 'package:otoserve/src/presentation/screen/home/home_screen.dart';
import 'package:otoserve/src/presentation/screen/profile/profile_screen.dart';
import 'package:otoserve/src/presentation/screen/riwayat/riwayat_screen.dart';
import 'package:otoserve/src/utils/colors.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetNavState();
}

class _BottomNavigationWidgetNavState extends State<BottomNavigationWidget> {
  int selectedIndex = 0;
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  void pageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.fastEaseInToSlowEaseOut);
    });
  }

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home_filled),
        label: 'Beranda',
      ),
      const BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.person_2_rounded), label: 'Profil'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {
          pageChanged(index);
        },
        children: const <Widget>[
          HomeScreen(),
          RiwayatScreen(),
          ProfileScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColor.primaryColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          bottomTapped(index);
        },
        items: buildBottomNavBarItems(),
      ),
    );
  }
}