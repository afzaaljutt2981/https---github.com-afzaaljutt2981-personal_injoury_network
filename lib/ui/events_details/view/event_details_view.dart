import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/app_buttons/app_primary_button.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_type.dart';

import '../../allParticipent/view/create_all_participants_view.dart';
import '../../allParticipent/view/participants_view.dart';
import '../../create_event/models/event_model.dart';
import '../../otherUserProfile/view/other_user_view.dart';
import 'events_qr_view.dart';

class EventsDetailsView extends StatefulWidget {
   EventsDetailsView({super.key,required this.event});
EventModel event;
  @override
  State<EventsDetailsView> createState() => _EventsDetailsViewState();
}

class _EventsDetailsViewState extends State<EventsDetailsView> {
  bool registerFee = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(19.sp),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.kPrimaryColor,
                size: 18.sp,
              ),
            ),
          ),
          title: Center(
            child: Text(
              "Event",
              style: AppTextStyles.josefin(
                  style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.kPrimaryColor,
              )),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: userType == 'user' ? 60.w : 30.w),
              child: userType == 'user'
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            childCurrent: widget,
                            type: PageTransitionType.rightToLeft,
                            alignment: Alignment.center,
                            duration: const Duration(milliseconds: 200),
                            reverseDuration: const Duration(milliseconds: 200),
                            child: const EventsQrView(),
                          ),
                        );
                      },
                      child: Image(
                        height: 22.sp,
                        width: 22.sp,
                        image: const AssetImage('assets/images/qr_events.png'),
                      ),
                    ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 200.h,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 10.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: Image(image: NetworkImage(widget.event.pImage),fit: BoxFit.cover,),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 20.w, top: 10.h, right: 20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Weekly Virtual Event',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 50.w,
                                          top: userType == 'user' ? 15.h : 25.h,
                                          bottom: 15.h),
                                      child: Image(
                                        height: 34.sp,
                                        width: 34.sp,
                                        image: const AssetImage(
                                            'assets/images/verified_icon_events.png'),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 95.h,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 50.w),
                                    child: Text(
                                      widget.event.title,
                                      style: AppTextStyles.josefin(
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF9EE8FF),
                                              fontSize: 22.sp)),
                                    ),
                                  ),
                                ),
                                userType == 'user'
                                    ? Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Row(
                                          children: [
                                            Image(
                                              height: 35.sp,
                                              width: 35.sp,
                                              image: const AssetImage(
                                                  'assets/images/profile_pic.png'),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "John Smith ",
                                                  style: AppTextStyles.josefin(
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                          fontSize: 13.sp)),
                                                ),
                                                CustomSizeBox(5.h),
                                                Text(
                                                  "Organizer ",
                                                  style: AppTextStyles.josefin(
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: const Color(
                                                              0xFF706E8F),
                                                          fontSize: 10.sp)),
                                                ),
                                              ],
                                            )),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 30.w),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.sp),
                                                    color: //Colors.purple.shade400

                                                        const Color(0xFF3C4784)
                                                            .withOpacity(
                                                                0.818)),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(10.sp),
                                                  child: Center(
                                                    child: Text(
                                                      "Follow",
                                                      style:
                                                          AppTextStyles.josefin(
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      11.sp)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                          top: 15.h,
                          bottom: 15.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'About this event',
                              style: AppTextStyles.josefin(
                                  style: TextStyle(
                                      color: AppColors.kBlackColor,
                                      fontSize: 15.sp)),
                            ),
                            RatingStars(
                              value: 3,
                              starBuilder: (index, color) {
                                return Icon(
                                  Icons.star_sharp,
                                  color: color,
                                  size: 15.sp,
                                );
                              },
                              starCount: 5,
                              starSize: 15.sp,
                              maxValue: 5,
                              starSpacing: 1,
                              maxValueVisibility: true,
                              valueLabelVisibility: false,
                              starOffColor: Colors.grey.shade400,
                              starColor: const Color(0xFFF9C24B),
                            )
                          ],
                        ),
                      ),
                      Text(
                      widget.event.description,style: AppTextStyles.josefin(
                            style: TextStyle(
                                color: AppColors.kBlackColor, fontSize: 12.sp)),
                      ),
                      CustomSizeBox(25.h),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFF3F4FC),
                            borderRadius: BorderRadius.circular(20.sp)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            calenderView('Mo', 7, false),
                            calenderView('Tu', 8, false),
                            calenderView('We', 9, false),
                            calenderView('Th', 10, true),
                            calenderView('Fr', 11, false),
                            calenderView('Sa', 12, false),
                          ],
                        ),
                      ),
                      CustomSizeBox(15.h),
                      Text(
                        'Next schedules',
                        style: AppTextStyles.josefin(
                            style: TextStyle(
                                color: AppColors.kBlackColor, fontSize: 14.sp)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 30.w, top: 20.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                eventDetails(
                                    'assets/images/calender_red_event.png',
                                    "Jan 09, 2021"),
                                CustomSizeBox(13.h),
                                eventDetails('assets/images/time_event.png',
                                    "11:30 am - 12.15 pm"),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                eventDetails('assets/images/video_event.png',
                                    "Virtual Event"),
                                CustomSizeBox(13.h),
                                eventDetails('assets/images/time_event.png',
                                    "4 Hours Duration")
                              ],
                            )
                          ],
                        ),
                      ),
                      CustomSizeBox(25.h),
                      Row(
                        children: [
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
                                  child: const OtherUserProfileScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: 40.sp,
                              width: 40.sp,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFF2F1F8)),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
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
                                  child: const OtherUserProfileScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: 40.sp,
                              width: 40.sp,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFF2F1F8)),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
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
                                  child: const OtherUserProfileScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: 40.sp,
                              width: 40.sp,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFF2F1F8)),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
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
                                  child: const OtherUserProfileScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height: 40.sp,
                              width: 40.sp,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFF2F1F8)),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
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
                                  child: const CreateAllParticipantsView(),
                                ),
                              );
                            },
                            child: Text(
                              '+92 Participants',
                              style: AppTextStyles.josefin(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12.sp),
                              ),
                            ),
                          )
                        ],
                      ),
                      CustomSizeBox(30.h)
                    ],
                  ),
                ),
              ),
            ),
            userType == 'user'
                ? Padding(
                    padding:
                        EdgeInsets.only(left: 40.w, right: 40.w, bottom: 20.h),
                    child: GetButton(
                        50.sp,
                        () {},
                        Text(
                          "Register",
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.sp)),
                        )),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      left: 29.w,
                      right: 29.w,
                      bottom: 25.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => _showBottomSheet(context),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.kPrimaryColor,
                                    width: 1.5.sp),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.sp)),
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 22.w, vertical: 14.h),
                                child: Center(
                                  child: Text(
                                    'Invite Guests',
                                    style: AppTextStyles.josefin(
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.kPrimaryColor,
                                            fontSize: 16.sp)),
                                  ),
                                )),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xFFD70E0E),
                                  width: 1.5.sp),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.sp)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22.w, vertical: 14.h),
                              child: Center(
                                child: Text(
                                  'Cancel Event',
                                  style: AppTextStyles.josefin(
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFFD70E0E),
                                          fontSize: 16.sp)),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
          ],
        ));
  }

  Widget calenderView(String day, int date, bool eventDay) {
    return Container(
      decoration: BoxDecoration(
          color: eventDay == false ? null : const Color(0xFFD70E0E),
          borderRadius: BorderRadius.circular(15.sp)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: [
            Text(day,
                style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: eventDay == false
                        ? AppColors.kPrimaryColor
                        : Colors.white)),
            CustomSizeBox(7.h),
            Text(date.toString(),
                style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: eventDay == false
                        ? const Color(0xFF8A8BB1)
                        : Colors.white))
          ],
        ),
      ),
    );
  }

  Widget eventDetails(String image, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image(
          height: 17.sp,
          width: 17.sp,
          image: AssetImage(image),
        ),
        SizedBox(
          width: 7.w,
        ),
        Text(
          date,
          style: AppTextStyles.josefin(
              style: TextStyle(
                  color: AppColors.kBlackColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  bool isInvited = false;

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.sp),
          topRight: Radius.circular(30.sp),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.sp),
                    topRight: Radius.circular(30.sp),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSizeBox(7.h),
                      Center(
                        child: Container(
                          height: 5.h,
                          width: 25.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sp),
                              color: const Color(0xFFB2B2B2).withOpacity(0.50)),
                        ),
                      ),
                      CustomSizeBox(20.h),
                      Text(
                        'Invite Friend',
                        style: AppTextStyles.josefin(
                            style: TextStyle(
                                color: const Color(0xFF120D26),
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500)),
                      ),
                      CustomSizeBox(10.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFF0F0F0)),
                          borderRadius: BorderRadius.circular(25.sp),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                maxLines: 1,
                                readOnly: false,
                                style: AppTextStyles.josefin(
                                    style: TextStyle(
                                        color: const Color(0xFF1F314A),
                                        fontSize: 16.sp)),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 12.w),
                                    border: InputBorder.none,
                                    hintText: "Search",
                                    hintStyle: AppTextStyles.josefin(
                                        style: TextStyle(
                                            color: const Color(0xFF1F314A)
                                                .withOpacity(0.40),
                                            fontSize: 13.sp))),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20.w, left: 5.w),
                              child: Image(
                                height: 18.sp,
                                width: 18.sp,
                                image: const AssetImage(
                                    'assets/images/search_icon.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: 25,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 20.h,
                                              top: index == 0 ? 25.h : 0.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image(
                                                image: const AssetImage(
                                                    'assets/images/profile_pic.png'),
                                                width: 45.sp,
                                                height: 45.sp,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Micheal Ulasi',
                                                    style: AppTextStyles.josefin(
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xFF120D26),
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ),
                                                  CustomSizeBox(5.h),
                                                  Text(
                                                    '2k Follwers',
                                                    style: AppTextStyles.josefin(
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xFF747688),
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                  ),
                                                ],
                                              )),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 20.w),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isInvited = !isInvited;
                                                    });
                                                  },
                                                  child: Image(
                                                    height: 18.sp,
                                                    width: 18.sp,
                                                    image: isInvited
                                                        ? const AssetImage(
                                                            'assets/images/select_invite_friend.png')
                                                        : const AssetImage(
                                                            'assets/images/no_select_invite_friend.png'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        index == 24
                                            ? CustomSizeBox(90.h)
                                            : CustomSizeBox(0.h),
                                      ],
                                    );
                                  })),
                          Positioned(
                            bottom: 20.h,
                            right: 10.w,
                            left: 10.w,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GetButton(
                                  50.sp,
                                  () {},
                                  Text(
                                    'Invite',
                                    style: AppTextStyles.josefin(
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500)),
                                  )),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
