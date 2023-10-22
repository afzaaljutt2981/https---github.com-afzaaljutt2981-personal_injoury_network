import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_type.dart';

import '../../../global/app_buttons/app_primary_button.dart';
import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../drawer/view/create_drawer_view.dart';
import '../../drawer/view/drawer_home.dart';
import '../../events/view/search_events_view.dart';
import '../../events_details/view/create_event_details_view.dart';
import '../../events_details/view/event_details_view.dart';
import '../../notifications/view/create_notifications_view.dart';
import '../../notifications/view/notification_view.dart';
import 'navigation_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.white, height: screenHeight),
          Positioned(
            top: 0,
            child: Container(
              color: AppColors.kPrimaryColor,
              width: screenWidth,
              height: screenHeight * 0.7,
              child: Align(
                alignment: Alignment.topRight,
                child: Image(
                  height: 180.sp,
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
              padding: EdgeInsets.only(
                left: 15.w,
                right: 25.w,
              ),
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
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                childCurrent: widget,
                                type: PageTransitionType.leftToRight,
                                duration: const Duration(milliseconds: 200),
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
                        userType == 'user'
                            ? GestureDetector(
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
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  Text(
                    "Welcome Afzaal",
                    style: AppTextStyles.josefin(
                        style: TextStyle(
                            color: const Color(0xFFB2E5F5),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                  CustomSizeBox(10.h),
                  Text(
                    userType == 'user'
                        ? "Find Amazing Events Near You"
                        : "Create Amazing Events for audience",
                    style: AppTextStyles.josefin(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700)),
                  ),
                  userType == 'user'
                      ? Padding(
                          padding: EdgeInsets.only(
                            top: 20.h,
                            bottom: 20.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                height: 20.sp,
                                width: 20.sp,
                                image: const AssetImage(
                                    'assets/images/location_yellow.png'),
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              Text(
                                "258 events around you",
                                style: AppTextStyles.josefin(
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  userType == 'user'
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.sp),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        childCurrent: widget,
                                        type: PageTransitionType.size,
                                        alignment: Alignment.center,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        reverseDuration:
                                            const Duration(milliseconds: 200),
                                        child: const SearchEventScreen(),
                                      ),
                                    );
                                  },
                                  maxLines: 1,
                                  readOnly: true,
                                  style: AppTextStyles.josefin(
                                      style: TextStyle(
                                          color: const Color(0xFF1F314A),
                                          fontSize: 13.sp)),
                                  decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.only(left: 12.w),
                                      border: InputBorder.none,
                                      hintText: "Search Events",
                                      hintStyle: AppTextStyles.josefin(
                                          style: TextStyle(
                                              color: const Color(0xFF1F314A)
                                                  .withOpacity(0.40),
                                              fontSize: 13.sp))),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20.w),
                                child: Image(
                                  height: 18.sp,
                                  width: 18.sp,
                                  image: const AssetImage(
                                      'assets/images/search_icon.png'),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  CustomSizeBox(20.h),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height:
                  userType == 'user' ? screenHeight * 0.49 : screenHeight * 0.6,
              width: screenWidth,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.sp),
                    topRight: Radius.circular(30.sp),
                  )),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomSizeBox(15.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              userType == 'user'
                                  ? "Nearest Events"
                                  : "Upcoming Events",
                              style: AppTextStyles.josefin(
                                style: TextStyle(
                                    color: const Color(0xFF16183B),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    childCurrent: widget,
                                    type: PageTransitionType.rightToLeft,
                                    alignment: Alignment.center,
                                    duration: const Duration(milliseconds: 200),
                                    reverseDuration:
                                        const Duration(milliseconds: 200),
                                    child: BottomNavigationScreen(
                                      selectedIndex: 3,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                userType == 'user'
                                    ? "See All"
                                    : "See All Events",
                                style: AppTextStyles.josefin(
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: userType == 'user'
                                          ? const Color(0xFF9CA5D6)
                                          : const Color(0xFF4571E1),
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomSizeBox(13.h),
                      ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: 10,
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 25.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    //  height: 140.sp,
                                    width: 110.sp,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                'assets/images/intro_background_image.png'),
                                            fit: BoxFit.cover)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 8.w,
                                          top: 8.h,
                                          bottom: 70.h,
                                          right: 55.w),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20.sp)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            CustomSizeBox(5.h),
                                            Text("21",
                                                style:
                                                    GoogleFonts.sourceCodePro(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                        fontSize: 15.sp)),
                                            Text("MAR",
                                                style:
                                                    GoogleFonts.sourceCodePro(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black,
                                                        fontSize: 9.sp)),
                                            CustomSizeBox(5.h),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "1.4 KM AWAY",
                                                style: AppTextStyles.josefin(
                                                    style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: const Color(
                                                            0xFFACB1D9))),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Container(
                                                height: 2,
                                                width: 100.w,
                                                color: const Color(0xFFF0F1FA),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 10.w,
                                                top: 10.h,
                                                bottom: 7.h),
                                            child: Text(
                                              'Local Hero hror dskh hero ',
                                              style: AppTextStyles.josefin(
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Image(
                                                height: 18.sp,
                                                width: 18.sp,
                                                image: const AssetImage(
                                                    'assets/images/location_blue.png'),
                                              ),
                                              SizedBox(
                                                width: 7.w,
                                              ),
                                              Text(
                                                "South Statue Art Center",
                                                style: AppTextStyles.josefin(
                                                    style: TextStyle(
                                                        color: const Color(
                                                            0xFF585DF9),
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                            ],
                                          ),
                                          CustomSizeBox(12.h),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 60.w),
                                            child: GetButton(
                                              40.sp,
                                              () {
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    childCurrent: widget,
                                                    type: PageTransitionType
                                                        .leftToRightWithFade,
                                                    alignment: Alignment.center,
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    reverseDuration:
                                                        const Duration(
                                                            milliseconds: 200),
                                                    child:
                                                        const CreateEventDetailsView(),
                                                  ),
                                                );
                                              },
                                              Text(
                                                "View Event",
                                                style: AppTextStyles.josefin(
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
