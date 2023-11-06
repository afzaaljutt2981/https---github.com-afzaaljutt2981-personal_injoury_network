import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/utils/constants.dart';
import 'package:personal_injury_networking/ui/admin/admin_home/all_registered_marketers/view/create_all_registered_users_view.dart';
import 'package:personal_injury_networking/ui/events/controller/events_controller.dart';
import 'package:provider/provider.dart';

import '../../../../../global/helper/custom_sized_box.dart';
import '../../../../../global/utils/app_colors.dart';
import '../../../../../global/utils/app_text_styles.dart';
import '../../../../allFriends/view/create_all_freinds_view.dart';
import '../../../../authentication/model/user_model.dart';
import '../../../../create_event/models/event_model.dart';
import '../../../../drawer/view/create_drawer_view.dart';
import '../../../../events/view/create_all_events_view.dart';
import '../../../../notifications/view/create_notifications_view.dart';
import '../../../../qr_scan_screen/view/create_qr_scan_view.dart';
import '../../../all_registered_users/view/create_all_registered_users_view.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AdminHomeScreen> {
  List<EventModel> events = [];
  UserModel? user;
  List<UserModel> allUsers = [];

  @override
  Widget build(BuildContext context) {
    events = [];
    allUsers = context.watch<EventsController>().allUsers;
    if (allUsers.isNotEmpty && FirebaseAuth.instance.currentUser != null) {
      user = allUsers.firstWhere(
          (element) => element.id == FirebaseAuth.instance.currentUser!.uid);
    }
    if (Constants.userType == "user") {
      events = context.watch<EventsController>().allEvents;
    } else if (FirebaseAuth.instance.currentUser != null) {
      events = context
          .watch<EventsController>()
          .allEvents
          .where((element) =>
              element.uId == FirebaseAuth.instance.currentUser!.uid)
          .toList();
    }
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: (user != null)
          ? Stack(
              children: [
                Container(color: Colors.white, height: screenHeight),
                Positioned(
                  top: 0,
                  child: Container(
                    color: AppColors.kPrimaryColor,
                    width: screenWidth,
                    height: screenHeight * 0.3,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Image(
                        height: screenHeight * 0.2,
                        width: 172.sp,
                        image: const AssetImage(
                            'assets/images/home_background_graph.png'),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 15.w, right: 25.w, top: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 25.h,
                            bottom: 25.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (FirebaseAuth.instance.currentUser?.email !=
                                  Constants.adminEmail)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        childCurrent: widget,
                                        type: PageTransitionType.leftToRight,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        reverseDuration:
                                            const Duration(milliseconds: 200),
                                        child: const CreateDrawerView(),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Image(
                                      height: 30.sp,
                                      width: 30.sp,
                                      image: const AssetImage(
                                          'assets/images/main_menu_drawer.png'),
                                    ),
                                  ),
                                ),
                              // Constants.userType == 'marketer'
                              //     ?
                              if (FirebaseAuth.instance.currentUser?.email !=
                                  Constants.adminEmail)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        childCurrent: widget,
                                        type: PageTransitionType.rightToLeft,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        reverseDuration:
                                            const Duration(milliseconds: 200),
                                        child: const CreateNotificationsView(),
                                      ),
                                    );
                                  },
                                  child: Image(
                                    height: 20.sp,
                                    width: 20.sp,
                                    image: const AssetImage(
                                        'assets/images/notification.png'),
                                  ),
                                )
                              // : const SizedBox(),
                            ],
                          ),
                        ),
                        Text(
                          "Welcome \n${user!.userName}!",
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: const Color(0xFFFFFFFF),
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      height: Constants.userType == 'user'
                          ? screenHeight * 0.7
                          : screenHeight * 0.8,
                      width: screenWidth,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.sp),
                            topRight: Radius.circular(30.sp),
                          )),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 20,
                              left: 20,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      childCurrent: widget,
                                      type: PageTransitionType.leftToRight,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      reverseDuration:
                                          const Duration(milliseconds: 200),
                                      child:
                                          const CreateAllRegisteredUsersView(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: screenWidth * 0.4,
                                  height: 114,
                                  padding: const EdgeInsets.all(16),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF111827),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1, color: Color(0xFFE5E7EB)),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(),
                                        child: Center(
                                          child: Image(
                                            height: 80.sp,
                                            width: 80.sp,
                                            image: const AssetImage(
                                                'assets/images/tabler_users.png'),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'List of All\nRegistered Users',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: 'Josefin Sans',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              right: 20,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      childCurrent: widget,
                                      type: PageTransitionType.leftToRight,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      reverseDuration:
                                          const Duration(milliseconds: 200),
                                      child:
                                          const CreateAllRegisteredMarketersView(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: screenWidth * 0.4,
                                  height: 114,
                                  padding: const EdgeInsets.all(16),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFFFFFFF),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1, color: Color(0xFFE5E7EB)),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(),
                                        child: Center(
                                          child: Image(
                                            height: 80.sp,
                                            width: 80.sp,
                                            image: const AssetImage(
                                                'assets/images/tabler_users.png'),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'List of All\nMarketers',
                                        style: TextStyle(
                                          color: Color(0xFF111827),
                                          fontSize: 14,
                                          fontFamily: 'Josefin Sans',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 150,
                              left: 20,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      childCurrent: widget,
                                      type: PageTransitionType.leftToRight,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      reverseDuration:
                                          const Duration(milliseconds: 200),
                                      child: const CreateAllEventsView(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: screenWidth * 0.4,
                                  height: 114,
                                  padding: const EdgeInsets.all(16),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFFFFFFF),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1, color: Color(0xFFE5E7EB)),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(),
                                        child: Center(
                                          child: Image(
                                            height: 80.sp,
                                            width: 80.sp,
                                            image: const AssetImage(
                                                'assets/images/frame.png'),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'View All Events\nOrganized',
                                        style: TextStyle(
                                          color: Color(0xFF111827),
                                          fontSize: 14,
                                          fontFamily: 'Josefin Sans',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 150,
                              right: 20,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      childCurrent: widget,
                                      type: PageTransitionType.leftToRight,
                                      duration:
                                          const Duration(milliseconds: 200),
                                      reverseDuration:
                                          const Duration(milliseconds: 200),
                                      child: const CreateQrScanView(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: screenWidth * 0.4,
                                  height: 114,
                                  padding: const EdgeInsets.all(16),
                                  decoration: ShapeDecoration(
                                    color: Color(0xFFFFFFFF),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1, color: Color(0xFFE5E7EB)),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(),
                                        child: Center(
                                          child: Image(
                                            height: 80.sp,
                                            width: 80.sp,
                                            image: const AssetImage(
                                                'assets/images/qr_admin.png'),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'QR Scan to Find\n Users',
                                        style: TextStyle(
                                          color: Color(0xFF111827),
                                          fontSize: 14,
                                          fontFamily: 'Josefin Sans',
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            )
          : const CircularProgressIndicator(),
    );
  }
}
