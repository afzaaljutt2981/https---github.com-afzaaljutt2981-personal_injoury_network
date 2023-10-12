import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/ui/events/view/all_events_screen.dart';
import 'package:personal_injury_networking/ui/home/view/home_screen.dart';
import 'package:personal_injury_networking/ui/scan_screen/view/qr_scan_view.dart';
import '../../chat_screen/view/all_users.dart';
import '../../user_profile/user_profile.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {

  int _selectedIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _selectedIndex = index);
          },
          children:  <Widget>[
            const HomeScreen(),
            const AllUsersChat(),
            const HomeQrScanView(),
            const AllEventScreen(),
            BasicInfo('Afzaal', 'Jutt', 'afzal@gmail.com' )
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
        height: 65.h,
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
                icon:
                    ImageIcon(AssetImage('assets/images/home_icon_home_b.png')),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon:
                    ImageIcon(AssetImage('assets/images/chat_icon_home_b.png')),
                label: "Messages",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/images/qr_icon_home_b.png')),
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
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController?.animateToPage(index,
          duration: const Duration(milliseconds: 200), curve: Curves.linear);
    });
  }
}
