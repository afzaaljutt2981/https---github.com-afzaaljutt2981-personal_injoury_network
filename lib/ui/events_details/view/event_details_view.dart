import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/app_buttons/app_primary_button.dart';
import 'package:personal_injury_networking/global/helper/api_functions.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/helper/image_view.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';
import 'package:personal_injury_networking/global/utils/constants.dart';
import 'package:personal_injury_networking/global/utils/functions.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/chat_screen/view/invite_guests.dart';
import 'package:personal_injury_networking/ui/events/controller/events_controller.dart';
import 'package:personal_injury_networking/ui/events_details/controller/event_details_controller.dart';
import 'package:personal_injury_networking/ui/otherUserProfile/view/create_other_profile_view.dart';
import 'package:provider/provider.dart';

import '../../allParticipent/view/participants_view.dart';
import '../../create_event/models/event_model.dart';
import '../../notifications/model/nitofications_model.dart';
import '../../otherUserProfile/controller/other_user_profile_controller.dart';
import '../models/ticket_model.dart';
import 'events_qr_view.dart';

// ignore: must_be_immutable
class EventsDetailsView extends StatefulWidget {
  EventsDetailsView({super.key, required this.event});

  EventModel event;

  @override
  State<EventsDetailsView> createState() => _EventsDetailsViewState();
}

CollectionReference ref = FirebaseFirestore.instance.collection("users");

class _EventsDetailsViewState extends State<EventsDetailsView> {
  bool? registerFee = false;
  String? followButton = "Follow";
  List<EventModel?>? userEvents = [];
  List<TicketModel?>? userTickets = [];
  List<UserModel?>? eventParticipants = [];
  List<UserModel?>? allUsers = [];
  List<TicketModel?>? eventTickets = [];
  UserModel? currentUser;
  UserModel? eventCreater;
  String? notifyId = "";
  List<DateTime?>? weekDates = [];
  String? buttonName = "Register";

  @override
  Widget build(BuildContext context) {
    eventTickets = [];
    weekDates = [];
    eventParticipants = [];
    allUsers = context.watch<EventsController>().allUsers;
    eventTickets = context.watch<EventDetailsController>().eventTickets;
    List<NotificationsModel> notifications =
        context.watch<OtherUserProfileController>().notifications;
    setData(notifications);
    setRegisterButton();
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.event.dateTime ?? 0);
    DateTime startTime =
        DateTime.fromMillisecondsSinceEpoch(widget.event.startTime ?? 0);
    DateTime endTime =
        DateTime.fromMillisecondsSinceEpoch(widget.event.endTime ?? 0);
    DateTime today = DateTime.now();
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(widget.event.dateTime ?? 0);
    addWeekDates(dateTime);
    String formattedDiff = calculateDiff(endTime, startTime);
    String startFormat = DateFormat("HH:MM a").format(startTime);
    String endFormat = DateFormat("HH:MM a").format(endTime);
    String formattedDate = DateFormat('d MMM, y').format(dateTime);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(10.sp),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              width: 30.sp,
              height: 40.sp,
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColors.kPrimaryColor,
                size: 18.sp,
              ),
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
                      if (date.isAfter(DateTime.now()) &&
                          widget.event.status == "UpComing") {
                        Navigator.push(
                          context,
                          PageTransition(
                            childCurrent: widget,
                            type: PageTransitionType.rightToLeft,
                            alignment: Alignment.center,
                            duration: const Duration(milliseconds: 200),
                            reverseDuration: const Duration(milliseconds: 200),
                            child: EventsQrView(
                              eventId: widget.event.id,
                            ),
                          ),
                        );
                      }
                    },
                    child: Image(
                      height: 22.sp,
                      width: 22.sp,
                      color: (date.isAfter(DateTime.now()) &&
                              widget.event.status == "UpComing")
                          ? null
                          : Colors.grey,
                      image: const AssetImage('assets/images/qr_events.png'),
                    ),
                  ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (currentUser == null) ...[
            const Center(
              child: CircularProgressIndicator(),
            )
          ] else ...[
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ImageView(
                                      imageUrl: widget.event.pImage ?? "")));
                        },
                        child: Stack(
                          children: [
                            Container(
                              height: 200.h,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 10.h),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.sp),
                                child: Image(
                                  image:
                                      NetworkImage(widget.event.pImage ?? ""),
                                  // 'assets/images/background_events_admin.png'
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 20.w, top: 30.h, right: 20.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // Text('Weekly Virtual Event',
                                      //     style: GoogleFonts.montserrat(
                                      //       fontSize: 11.sp,
                                      //       fontWeight: FontWeight.w600,
                                      //       color: Colors.white,
                                      //     )),
                                      // Padding(
                                      //   padding: EdgeInsets.only(
                                      //       left: 50.w,
                                      //       top: Constants.userType == 'user'
                                      //           ? 15.h
                                      //           : 25.h,
                                      //       bottom: 15.h),
                                      //   child: Image(
                                      //     height: 34.sp,
                                      //     width: 34.sp,
                                      //     image: const AssetImage(
                                      //         'assets/images/verified_icon_events.png'),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 95.h,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 50.w),
                                      child: Text(
                                        widget.event.title ?? "",
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
                      ),
                      if (Constants.userType == 'user' &&
                          FirebaseAuth.instance.currentUser?.email
                                  ?.toLowerCase() !=
                              Constants.adminEmail.toLowerCase())
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
                                value: 0,
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
                        )
                      else
                        SizedBox(
                          height: 20,
                        ),
                      Text(
                        widget.event.description ?? "",
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
                            for (var e in weekDates ?? [])
                              calenderView(e, dateTime),
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
                      if ((eventParticipants?.length ?? 0) > 2) ...[
                        Row(
                          children: [
                            for (var i = 0; i < 2; i++)
                              participant(eventParticipants?[i]),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => AllParticipantsView(
                                              users: eventParticipants ?? [],
                                              currentUser: currentUser!,
                                            )));
                              },
                              child: Text(
                                "+${(eventParticipants?.length ?? 0) - 2} Participants",
                                style: const TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                        )
                      ] else ...[
                        Row(children: [
                          for (var e in eventParticipants ?? []) participant(e)
                        ])
                      ],
                    ],
                  ),
                ),
              ),
            ),
            currentUser!.userType == 'user' &&
                    FirebaseAuth.instance.currentUser?.email?.toLowerCase() !=
                        Constants.adminEmail.toLowerCase()
                ? Padding(
                    padding:
                        EdgeInsets.only(left: 40.w, right: 40.w, bottom: 20.h),
                    child: GetButton(50.sp, () async {
                      if (buttonName != "Registered") {
                        Functions.showLoaderDialog(context);
                        await context
                            .read<EventDetailsController>()
                            .addEventTicket(widget.event);
                        // ignore: use_build_context_synchronously
                        await context
                            .read<EventDetailsController>()
                            .addUserTicket(widget.event.id ?? "");
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        // ignore: use_build_context_synchronously
                        Functions.showSnackBar(
                            context, "Event register successfully");
                      }
                    },
                        Text(
                          buttonName ?? "",
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
                              onTap: () {
                                if (((date.year == today.year &&
                                            date.month == today.month &&
                                            date.day == today.day) &&
                                        startTime.isBefore(DateTime.now()) &&
                                        endTime.isAfter(DateTime.now()) &&
                                        widget.event.status == "UpComing") ||
                                    ((date.isAfter(DateTime.now()) &&
                                        widget.event.status == "UpComing"))) {
                                  _showBottomSheet(context);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: (((date.year == today.year &&
                                                        date.month ==
                                                            today.month &&
                                                        date.day ==
                                                            today.day) &&
                                                    startTime.isBefore(
                                                        DateTime.now()) &&
                                                    endTime.isAfter(
                                                        DateTime.now()) &&
                                                    widget.event.status ==
                                                        "UpComing") ||
                                                ((date.isAfter(
                                                        DateTime.now()) &&
                                                    widget.event.status ==
                                                        "UpComing")))
                                            ? AppColors.kPrimaryColor
                                            : Colors.grey,
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
                                                color: (((date.year == today.year &&
                                                                date.month ==
                                                                    today
                                                                        .month &&
                                                                date.day ==
                                                                    today
                                                                        .day) &&
                                                            startTime.isBefore(
                                                                DateTime
                                                                    .now()) &&
                                                            endTime.isAfter(DateTime
                                                                .now()) &&
                                                            widget.event.status ==
                                                                "UpComing") ||
                                                        ((date.isAfter(DateTime.now()) &&
                                                            widget.event.status ==
                                                                "UpComing")))
                                                    ? AppColors.kPrimaryColor
                                                    : Colors.grey,
                                                fontSize: 16.sp)),
                                      ),
                                    )),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                if (date.isAfter(DateTime.now()) &&
                                    widget.event.status == "UpComing") {
                                  Functions.showLoaderDialog(context);
                                  await context
                                      .read<EventDetailsController>()
                                      .deleteEvent(widget.event.id ?? "");
                                  print(eventParticipants?.length);
                                  print("events ");

                                  eventParticipants?.forEach((element) async {
                                    if (element?.fcmToken != null) {
                                      await context
                                          .read<EventDetailsController>()
                                          .notifyCancelEvent(element!.id!,
                                              widget.event.title!);
                                      await CountryStateCityRepo
                                          .sendPushNotification(
                                              eventCreater!.firstName!,
                                              "Cancel the ${widget.event.title}",
                                              element?.fcmToken ?? "");
                                    }
                                  });
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ((date.isAfter(DateTime.now()) &&
                                                widget.event.status ==
                                                    "UpComing"))
                                            ? const Color(0xFFD70E0E)
                                            : Colors.grey,
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
                                              color: ((date.isAfter(
                                                          DateTime.now()) &&
                                                      widget.event.status ==
                                                          "UpComing"))
                                                  ? const Color(0xFFD70E0E)
                                                  : Colors.grey,
                                              fontSize: 16.sp)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
          ],
        ],
      ),
    );
  }

  Widget calenderView(DateTime date, DateTime eventDate) {
    String dayName = DateFormat("MMM").format(date);
    bool eventDay = false;
    if (date == eventDate) {
      eventDay = true;
    }
    return Container(
      decoration: BoxDecoration(
          color: eventDay == false ? null : const Color(0xFFD70E0E),
          borderRadius: BorderRadius.circular(15.sp)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Column(
          children: [
            Text(date.day.toString(),
                style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: eventDay == false
                        ? AppColors.kPrimaryColor
                        : Colors.white)),
            CustomSizeBox(7.h),
            Text(dayName,
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
          return InviteGuests(
            currentUser: currentUser!,
            event: widget.event,
            allUsers: allUsers ?? [],
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
                      eventCreater?.userName ?? "",
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
                if (FirebaseAuth.instance.currentUser?.email?.toLowerCase() !=
                    Constants.adminEmail.toLowerCase())
                  GestureDetector(
                    onTap: () async {
                      if (followButton == "Follow") {
                        context
                            .read<OtherUserProfileController>()
                            .sendFollowRequest(eventCreater?.id ?? "", context);
                      } else if (followButton == "Following") {
                        await context
                            .read<OtherUserProfileController>()
                            .followTap(eventCreater!);
                        // ignore: use_build_context_synchronously
                        await context
                            .read<OtherUserProfileController>()
                            .followingTap(currentUser!, eventCreater!.id);
                        // ignore: use_build_context_synchronously
                        await context
                            .read<OtherUserProfileController>()
                            .unFollow(eventCreater?.id ?? "", notifyId ?? "");
                      }
                    },
                    child: Padding(
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
                              followButton ?? "",
                              style: AppTextStyles.josefin(
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 11.sp)),
                            ),
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

  Widget participant(UserModel? user) {
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
          child: (user?.pImage != null)
              ? CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(user?.pImage ?? ""),
                )
              : Image(
                  width: 40.sp,
                  image: const AssetImage("assets/images/profile_pic.png"))),
    );
  }

  setRegisterButton() {
    for (var element in eventParticipants ?? []) {
      if (element.id == currentUser!.id) {
        buttonName = "Registered";
      }
    }
  }

  String calculateDiff(DateTime endTime, DateTime startTime) {
    Duration difference = endTime.difference(startTime);
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    String formattedDiff =
        "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
    return formattedDiff;
  }

  addWeekDates(DateTime dateTime) {
    DateTime tempDate = dateTime.subtract(const Duration(days: 3));
    for (var i = 0; i < 6; i++) {
      weekDates?.add(tempDate.add(Duration(days: i)));
    }
  }

  setData(List<NotificationsModel> notifications) {
    if (allUsers?.isNotEmpty == true) {
      currentUser = allUsers?.firstWhere(
          (element) => element?.id == FirebaseAuth.instance.currentUser!.uid);
      eventCreater =
          allUsers?.firstWhere((element) => element?.id == widget.event.uId);
      setFollowButton(notifications);
      for (var element1 in eventTickets ?? []) {
        eventParticipants?.add(
            allUsers?.firstWhere((element) => element?.id == element1.uId));
      }
    }
  }

  setFollowButton(List<NotificationsModel> notifications) {
    for (var element in notifications) {
      if (element.senderId == FirebaseAuth.instance.currentUser!.uid &&
          element.status != "Rejected" &&
          element.status != "unFollowed") {
        if (element.status == "Accepted") {
          followButton = "Following";
          notifyId = element.id;
        } else {
          followButton = element.status;
        }
      }
    }
  }
}
