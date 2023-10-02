import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_injury_networking/global/app_buttons/app_primary_button.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';
import '../../chat_screen/view/chat_view.dart';
import '../../create_event/view/add_event_view.dart';
import '../../drawer/view/drawer_home.dart';
import '../../events/view/search_events_view.dart';
import '../../events_details/view/events_view.dart';
import '../../notifications/view/notification_view.dart';
import '../../orginizer_profile/view/orgnaizer_view.dart';
import '../../scan_screen/view/qr_scan_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
                image:
                    const AssetImage('assets/images/home_background_graph.png'),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.w, right: 25.w),
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
                            MaterialPageRoute(
                                builder: (context) => const MyDrawerHome()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Image(
                          height: 50.sp,
                          width: 50.sp,
                          image:
                              const AssetImage('assets/images/profile_pic.png'),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NotificationView()));
                      },
                      child: Image(
                        height: 20.sp,
                        width: 20.sp,
                        image:
                            const AssetImage('assets/images/notification.png'),
                      ),
                    ),
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
                "Find Amazing Events Near You",
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700)),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20.h,
                  bottom: 20.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image(
                      height: 22.sp,
                      width: 22.sp,
                      image:
                          const AssetImage('assets/images/location_yellow.png'),
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
              ),
              Container(
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
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SearchEventScreen()));
                        },
                        maxLines: 1,
                        readOnly: true,
                        //  controller: controller,
                        style: AppTextStyles.josefin(
                            style: TextStyle(
                                color: const Color(0xFF1F314A),
                                fontSize: 13.sp)),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 12.w),
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
                        image:
                            const AssetImage('assets/images/search_icon.png'),
                      ),
                    ),
                  ],
                ),
              ),
              CustomSizeBox(20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    homeFeatures(
                      'assets/images/person_home.png',
                      'Users',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const OrgnaizerProfileScreen()));
                      },
                    ),
                    homeFeatures(
                      'assets/images/sms_home.png',
                      'Chats',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChatScreen()));
                      },
                    ),
                    homeFeatures(
                      'assets/images/events_icon_home.png',
                      'Events',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddEventView()));
                      },
                    ),
                    homeFeatures(
                      'assets/images/qr_icon_home.png',
                      'QR',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeQrScanView()));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            height: screenHeight * 0.45,
            width: screenWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.sp),
                  topRight: Radius.circular(20.sp),
                )),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomSizeBox(10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Nearest Events",
                            style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: const Color(0xFF16183B),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Image(
                            height: 22.sp,
                            width: 22.sp,
                            image: const AssetImage(
                                'assets/images/more_horizental.png'),
                          ),
                        ],
                      ),
                    ),
                    CustomSizeBox(7.h),
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
                                              style: GoogleFonts.sourceCodePro(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                  fontSize: 15.sp)),
                                          Text("MAR",
                                              style: GoogleFonts.sourceCodePro(
                                                  fontWeight: FontWeight.w600,
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
                                          padding: EdgeInsets.only(right: 60.w),
                                          child: GetButton(
                                            40.sp,
                                            () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const EventsDetailsView()));
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
    ));
  }

  Widget homeFeatures(String image, String text, {required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Container(
            height: 45.sp,
            width: 45.sp,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF5156ED),
            ),
            child: Padding(
              padding: EdgeInsets.all(12.sp),
              child: Image(
                image: AssetImage(image),
              ),
            ),
          ),
          CustomSizeBox(12.h),
          Text(
            text,
            style: AppTextStyles.josefin(
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );
  }
}
