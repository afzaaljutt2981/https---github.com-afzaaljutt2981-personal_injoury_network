import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/app_buttons/app_primary_button.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';
import 'package:personal_injury_networking/global/utils/constants.dart';
import 'package:personal_injury_networking/global/utils/functions.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_type.dart';
import 'package:personal_injury_networking/ui/events/controller/events_controller.dart';
import 'package:personal_injury_networking/ui/events_details/controller/event_details_controller.dart';
import 'package:personal_injury_networking/ui/otherUserProfile/view/create_other_profile_view.dart';
import 'package:provider/provider.dart';

import '../../allParticipent/view/create_all_participants_view.dart';
import '../../allParticipent/view/participants_view.dart';
import '../../create_event/models/event_model.dart';
import '../../otherUserProfile/view/other_user_view.dart';
import '../models/ticket_model.dart';
import 'events_qr_view.dart';

class EventsDetailsView extends StatefulWidget {
  EventsDetailsView({super.key, required this.event});
  EventModel event;
  @override
  State<EventsDetailsView> createState() => _EventsDetailsViewState();
}

CollectionReference ref = FirebaseFirestore.instance.collection("users");

class _EventsDetailsViewState extends State<EventsDetailsView> {
  bool registerFee = false;
  List<UserModel> eventParticipants = [];
  List<UserModel> allUsers = [];
  List<TicketModel> eventTickets = [];
  UserModel? currentUser;
  UserModel? eventCreater;
  List<DateTime> weekDates = [];
  String buttonName = "Register";
  @override
  Widget build(BuildContext context) {
    eventTickets = [];
    allUsers = context.watch<EventsController>().allUsers;
    eventTickets = context.watch<EventDetailsController>().eventTickets;
    if (allUsers.isNotEmpty) {
      currentUser = allUsers.firstWhere(
          (element) => element.id == FirebaseAuth.instance.currentUser!.uid);
      eventCreater =
          allUsers.firstWhere((element) => element.id == widget.event.uId);
      eventParticipants = [];
      for (var element1 in eventTickets) {
        eventParticipants
            .add(allUsers.firstWhere((element) => element.id == element1.uId));
      }
    }
    for (var element in eventParticipants) {
      if (element.id == currentUser!.id) {
        buttonName = "Registered";
      }
    }
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.event.dateTime);
    DateTime startTime =
        DateTime.fromMillisecondsSinceEpoch(widget.event.startTime);
    DateTime endTime =
        DateTime.fromMillisecondsSinceEpoch(widget.event.endTime);
    Duration difference = endTime.difference(startTime);
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    String formattedDiff =
        "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
    String startFormat = DateFormat("HH:MM a").format(startTime);
    String endFormat = DateFormat("HH:MM a").format(endTime);
    String formattedDate = DateFormat('d MMM, y').format(dateTime);
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
              padding: EdgeInsets.only(
                  right: Constants.userType == 'user' ? 60.w : 30.w),
              child: Constants.userType == 'user'
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
                            child: Constants.userType == 'user'
                                ? const Image(
                                    image: AssetImage(
                                        'assets/images/background_events.png'),
                                    fit: BoxFit.contain,
                                  )
                                : const Image(
                                    image: AssetImage(
                                        'assets/images/background_events_admin.png'),
                                    fit: BoxFit.contain,
                                  ),
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
                                          top: Constants.userType == 'user'
                                              ? 15.h
                                              : 25.h,
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
                                      "The Creative Coffee Talks Club",
                                      style: AppTextStyles.josefin(
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF9EE8FF),
                                              fontSize: 22.sp)),
                                    ),
                                  ),
                                ),
                                Constants.userType == 'user'
                                    ? marketerInfo()
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
                        widget.event.description,
                        style: AppTextStyles.josefin(
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
                                    formattedDate),
                                CustomSizeBox(13.h),
                                eventDetails('assets/images/time_event.png',
                                    "$startFormat - $endFormat"),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                eventDetails('assets/images/video_event.png',
                                    "Virtual Event"),
                                CustomSizeBox(13.h),
                                eventDetails('assets/images/time_event.png',
                                    "$formattedDiff Hours")
                              ],
                            )
                          ],
                        ),
                      ),
                      CustomSizeBox(25.h),
                      if (eventParticipants.length > 3) ...[
                        Row(
                          children: [
                            for (var i = 0; i < 3; i++)
                              participant(eventParticipants[i]),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => AllParticipantsView(
                                              users: eventParticipants,
                                              currentUser: currentUser!,
                                            )));
                              },
                              child: Text(
                                "+${eventParticipants.length - 3} Participants",
                                style: const TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                        )
                      ] else ...[
                        Row(children: [
                          for (var e in eventParticipants) participant(e)
                        ])
                      ],
                    ],
                  ),
                ),
              ),
            ),
            Constants.userType == 'user'
                ? Padding(
                    padding:
                        EdgeInsets.only(left: 40.w, right: 40.w, bottom: 20.h),
                    child: GetButton(50.sp, () async {
                      if (buttonName != "Registered") {
                        Functions.showLoaderDialog(context);
                        await context
                            .read<EventDetailsController>()
                            .addEventTicket(widget.event.id);
                        await context
                            .read<EventDetailsController>()
                            .addUserTicket(widget.event.id);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Functions.showSnackBar(
                            context, "Event register successfully");
                      }
                    },
                        Text(
                          buttonName,
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.sp)),
                        )),
                  )
                : (currentUser!.id != widget.event.uId)
                    ? const SizedBox()
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

  Widget marketerInfo() {
    return (eventCreater != null)
        ? Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                if (eventCreater!.pImage != null) ...[
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(eventCreater!.pImage!),
                  )
                ] else ...[
                  Image(
                    height: 35.sp,
                    width: 35.sp,
                    image: const AssetImage('assets/images/profile_pic.png'),
                  )
                ],
                SizedBox(
                  width: 15.w,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventCreater!.userName,
                      style: AppTextStyles.josefin(
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 13.sp)),
                    ),
                    CustomSizeBox(5.h),
                    Text(
                      "Organizer ",
                      style: AppTextStyles.josefin(
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF706E8F),
                              fontSize: 10.sp)),
                    ),
                  ],
                )),
                Padding(
                  padding: EdgeInsets.only(right: 30.w),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: //Colors.purple.shade400

                            const Color(0xFF3C4784).withOpacity(0.818)),
                    child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Center(
                        child: Text(
                          "Follow",
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontSize: 11.sp)),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : const SizedBox();
  }

  Widget participant(UserModel user) {
    print("participant");
    print(user.userName);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                childCurrent: widget,
                type: PageTransitionType.rightToLeft,
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 200),
                reverseDuration: const Duration(milliseconds: 200),
                child: CreateOtherUserProfileView(
                  participant: user,
                  currentUser: currentUser!,
                ),
              ),
            );
          },
          child: (user.pImage != null)
              ? CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(user.pImage!),
                )
              : Image(
                  width: 40.sp,
                  image: const AssetImage("assets/images/profile_pic.png"))),
    );
  }
}
