import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/ui/events/view/all_events_screen.dart';
import 'package:personal_injury_networking/ui/home/view/home_screen.dart';
import 'package:personal_injury_networking/ui/scan_screen/view/qr_scan_view.dart';
import '../../chat_screen/view/all_users.dart';
import '../../myProfile/my_profile.dart';

// ignore: must_be_immutable
class BottomNavigationScreen extends StatefulWidget {
  BottomNavigationScreen({required this.selectedIndex, super.key});
  int selectedIndex;
  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  PageController? _pageController;
  int? selectedIndex;
  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
    _pageController = PageController(initialPage: selectedIndex!);
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
        _pageController!.animateToPage(index,
            duration: const Duration(milliseconds: 200), curve: Curves.linear);
      });
    }

    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        body: SizedBox.expand(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => selectedIndex = index);
            },
            children: const <Widget>[
              HomeScreen(),
              AllUsersChat(),
              HomeQrScanView(),
              AllEventScreen(),
              MyProfileInfo()
            ],
          ),
        ), //widgets[selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.sp),
                topLeft: Radius.circular(20.sp)),
            boxShadow: const [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          height: Platform.isIOS ? null : 65.h,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.sp),
              topRight: Radius.circular(20.sp),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: GoogleFonts.poppins(
                  color: AppColors.kPrimaryColor, fontSize: 12.sp),
              showUnselectedLabels: true,
              elevation: 2,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: ImageIcon(
                      AssetImage('assets/images/home_icon_home_b.png')),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                      AssetImage('assets/images/chat_icon_home_b.png')),
                  label: "Messages",
                ),
                BottomNavigationBarItem(
                  icon:
                      ImageIcon(AssetImage('assets/images/qr_icon_home_b.png')),
                  label: "QR Scan",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                      AssetImage('assets/images/events_icon_home_b.png')),
                  label: "Events",
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                      AssetImage('assets/images/person_icon_home_b.png')),
                  label: "Profile",
                ),
              ],
              selectedItemColor: AppColors.kPrimaryColor,
              unselectedItemColor: AppColors.kBlackColor,
              currentIndex: selectedIndex!,
              onTap: onItemTapped,
            ),
          ),
        ),
      ),
    );
  }
}
