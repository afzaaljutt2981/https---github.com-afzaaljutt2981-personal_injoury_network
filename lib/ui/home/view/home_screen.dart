import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/utils/constants.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/events/controller/events_controller.dart';
import 'package:provider/provider.dart';

import '../../../global/app_buttons/app_primary_button.dart';
import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../create_event/models/event_model.dart';
import '../../drawer/view/create_drawer_view.dart';
import '../../events/view/search_events_view.dart';
import '../../events_details/view/create_event_details_view.dart';
import '../../notifications/view/create_notifications_view.dart';
import 'navigation_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    if (user != null && user!.userType == "user") {
      events = context.watch<EventsController>().allEvents;
    } else if (FirebaseAuth.instance.currentUser != null) {
      events = context
          .watch<EventsController>()
          .allEvents
          .where((element) =>
              element.uId == FirebaseAuth.instance.currentUser!.uid && element.status == "UpComing")
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
                          "Welcome ${user!.firstName}",
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: const Color(0xFFB2E5F5),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                        ),
                        CustomSizeBox(10.h),
                        Text(
                          Constants.userType == 'user'
                              ? "Find Amazing Events Near You"
                              : "Create Amazing Events for audience",
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700)),
                        ),
                        Constants.userType == 'user'
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
                                      "${events.length} events around you",
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
                        Constants.userType == 'user'
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
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              reverseDuration: const Duration(
                                                  milliseconds: 200),
                                              child: SearchEventScreen(
                                                events: events,
                                              ),
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
                                                    color:
                                                        const Color(0xFF1F314A)
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
                    height: Constants.userType == 'user'
                        ? screenHeight * 0.49
                        : screenHeight * 0.6,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Constants.userType == 'user'
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
                                          duration:
                                              const Duration(milliseconds: 200),
                                          reverseDuration:
                                              const Duration(milliseconds: 200),
                                          child: BottomNavigationScreen(
                                            selectedIndex: 3,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      Constants.userType == 'user'
                                          ? "See All"
                                          : "See All Events",
                                      style: AppTextStyles.josefin(
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Constants.userType == 'user'
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
                            if (events.isEmpty) ...[
                              CustomSizeBox(100.h),
                              const Center(child: Text("No Event Found!"))
                            ] else ...[
                              ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: events.length,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    int timestamp = events[index].dateTime ??
                                        0; // Assuming events[index].dateTime is a timestamp
                                    DateTime dateTime =
                                        DateTime.fromMillisecondsSinceEpoch(
                                            timestamp);
                                    String formattedDate =
                                        DateFormat('d MMM, y').format(dateTime);
                                    List<String> parts =
                                        formattedDate.split(' ');
                                    String firstPart = parts[0];
                                    String extractedMonth = '';
                                    if (parts.length >= 2) {
                                      extractedMonth = parts[1];
                                      extractedMonth =
                                          extractedMonth.replaceAll(',', '');
                                    }

                                    return events[index].status == 'UpComing'
                                        ? Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 25.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  //  height: 140.sp,
                                                  width: 110.sp,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.sp),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              events[index]
                                                                      .pImage ??
                                                                  ""),
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
                                                              BorderRadius
                                                                  .circular(
                                                                      20.sp)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          CustomSizeBox(5.h),
                                                          Text(
                                                              firstPart
                                                                  .toString(),
                                                              style: GoogleFonts.sourceCodePro(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      15.sp)),
                                                          Text(
                                                              extractedMonth
                                                                  .toString(),
                                                              style: GoogleFonts.sourceCodePro(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      12.sp)),
                                                          CustomSizeBox(5.h),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20.w),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            // Text(
                                                            //   "1.4 KM AWAY",
                                                            //   style: AppTextStyles.josefin(
                                                            //       style: TextStyle(
                                                            //           fontSize: 10.sp,
                                                            //           color: const Color(
                                                            //               0xFFACB1D9))),
                                                            // ),
                                                            SizedBox(
                                                              width: 10.w,
                                                            ),
                                                            Container(
                                                              height: 2,
                                                              width: 200.w,
                                                              color: const Color(
                                                                  0xFFF0F1FA),
                                                            )
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 10.w,
                                                                  top: 10.h,
                                                                  bottom: 7.h),
                                                          child: Text(
                                                            events[index]
                                                                    .title ??
                                                                "",
                                                            style: AppTextStyles.josefin(
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500)),
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
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
                                                            Expanded(
                                                              child: Text(
                                                                events[index]
                                                                        .address ??
                                                                    "",
                                                                style: AppTextStyles.josefin(
                                                                    style: TextStyle(
                                                                        color: const Color(
                                                                            0xFF585DF9),
                                                                        fontSize: 12
                                                                            .sp,
                                                                        fontWeight:
                                                                            FontWeight.w500)),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        CustomSizeBox(12.h),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 60.w),
                                                          child: GetButton(
                                                            40.sp,
                                                            () {
                                                              Navigator.push(
                                                                context,
                                                                PageTransition(
                                                                  childCurrent:
                                                                      widget,
                                                                  type: PageTransitionType
                                                                      .leftToRightWithFade,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  duration: const Duration(
                                                                      milliseconds:
                                                                          200),
                                                                  reverseDuration:
                                                                      const Duration(
                                                                          milliseconds:
                                                                              200),
                                                                  child:
                                                                      CreateEventDetailsView(
                                                                    event: events[
                                                                        index],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            Text(
                                                              "View Event",
                                                              style: AppTextStyles.josefin(
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500)),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : const SizedBox();
                                    // return SingleEventWidget(event: events[index]);
                                  })
                            ]
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
