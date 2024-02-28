import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/utils/functions.dart';
import 'package:personal_injury_networking/ui/create_event/models/event_model.dart';
import 'package:personal_injury_networking/ui/events/controller/events_controller.dart';
import 'package:provider/provider.dart';

import '../../ui/events_details/models/ticket_model.dart';
import '../../ui/events_details/view/create_event_details_view.dart';
import '../utils/app_text_styles.dart';
import '../utils/constants.dart';
import 'custom_sized_box.dart';

// ignore: must_be_immutable
class SingleEventWidget extends StatefulWidget {
  SingleEventWidget({super.key, required this.event});

  EventModel? event;

  @override
  State<SingleEventWidget> createState() => _SingleEventWidgetState();
}

class _SingleEventWidgetState extends State<SingleEventWidget> {
  @override
  void initState() {
    super.initState();
  }

  List<TicketModel> eventTickets = [];

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(widget.event?.dateTime??0);
    DateTime startTime =
        DateTime.fromMillisecondsSinceEpoch(widget.event?.startTime??0);
    String fStartTime = DateFormat("HH:mm a").format(startTime);
    String fDate = DateFormat("EEE,MMM d").format(date);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageTransition(
              childCurrent: widget,
              type: PageTransitionType.leftToRightWithFade,
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 200),
              reverseDuration: const Duration(milliseconds: 200),
              child: CreateEventDetailsView(
                event: widget.event,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.sp),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF535990).withOpacity(0.07),
                  spreadRadius: 6,
                  blurRadius: 6,
                  offset: Offset(0, 8.sp),
                )
              ]),
          child: Padding(
            padding: EdgeInsets.all(10.sp),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 90.sp,
                      width: 90.sp,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.sp),
                          image: DecorationImage(
                              image: NetworkImage(widget.event?.pImage ?? ""),
                              fit: BoxFit.cover)),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 20.w, right: 10.w, top: 5.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomSizeBox(3.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "$fDate - $fStartTime",
                                  style: AppTextStyles.josefin(
                                      style: TextStyle(
                                          color: const Color(0xFF3A51C8),
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500)),
                                ),
                                if (FirebaseAuth.instance.currentUser?.email
                                        ?.toLowerCase() ==
                                    Constants.adminEmail.toLowerCase())
                                  GestureDetector(
                                    onTap: () async {
                                      print("Delete should be initiated");
                                      if (widget.event?.id?.isNotEmpty ??
                                          false) {
                                        String? res = await Functions()
                                            .showConfirmDialogueBox(context,
                                                "Are you sure, you want to delete this event?");
                                        if (res != null) {
                                          context
                                              .read<EventsController>()
                                              .updateEventToDeleted(
                                                  widget.event, context);
                                        }
                                      } else {
                                        Functions.showSnackBar(context,
                                            "Invalid event, unable to delete this event");
                                      }
                                    },
                                    child: Image(
                                      height: 20.sp,
                                      width: 20.sp,
                                      image: const AssetImage(
                                          'assets/images/delete.png'),
                                    ),
                                  ),
                              ],
                            ),
                            CustomSizeBox(5.h),
                            Text(
                              widget.event?.title ?? "",
                              style: AppTextStyles.josefin(
                                  style: TextStyle(
                                      color: const Color(0xFF120D26),
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500)),
                            ),
                            CustomSizeBox(12.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.place,
                                  color: Colors.grey,
                                  size: 15.sp,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Expanded(
                                  child: Text(
                                    widget.event?.address ?? "",
                                    style: AppTextStyles.josefin(
                                        style: TextStyle(
                                            color: const Color(0xFF747688),
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                              ],
                            ),
                            CustomSizeBox(3.h),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.event?.participants} participants",
                        style: AppTextStyles.josefin(
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 12.sp)),
                      ),
                      eventStatus(widget.event?.status ?? '', context)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget eventStatus(String status, BuildContext context) {
    Color? bgColor;
    Color? textColor;
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(widget.event?.dateTime ?? 0);
    DateTime today = DateTime.now();
    DateTime startTime =
        DateTime.fromMillisecondsSinceEpoch(widget.event?.startTime??0);
    DateTime endTime =
        DateTime.fromMillisecondsSinceEpoch(widget.event?.endTime??0);
    if (status == 'Cancelled') {
      bgColor = Colors.red.shade100;
      textColor = Colors.red.shade600;
    } else {
      if ((date.year == today.year &&
              date.month == today.month &&
              date.day == today.day) &&
          startTime.isBefore(DateTime.now()) &&
          endTime.isAfter(DateTime.now())) {
        status = "Started";
        bgColor = const Color(0xFF0AFF31);
        textColor = const Color(0xFF17DF1F);
      } else if (date.isBefore(DateTime.now()) &&
          endTime.isBefore(DateTime.now()) &&
          status != "cancelled") {
        status = "Completed";
        bgColor = const Color(0xFF49E73C).withOpacity(0.4);
        textColor = const Color(0xFF17DF1F);
      } else if (endTime.isAfter(DateTime.now()) && status == "UpComing") {
        status = "Up Coming";
        // bgColor = Colors.yellow.shade200;
        bgColor = const Color(0xffF3F633);
        textColor = Colors.yellow.shade700;
      } else if (status == "Cancelled") {
        bgColor = Colors.red.shade100;
        textColor = Colors.red.shade600;
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: textColor ?? Colors.yellow),
        borderRadius: BorderRadius.circular(20.sp),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.sp),
        child: Text(
          status,
          style: AppTextStyles.josefin(
              style: TextStyle(color: textColor, fontSize: 12.sp)),
        ),
      ),
    );
  }
}
