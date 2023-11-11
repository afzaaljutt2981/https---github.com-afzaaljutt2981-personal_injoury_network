import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/ui/create_event/models/event_model.dart';

import '../../ui/events_details/view/create_event_details_view.dart';
import '../app_buttons/app_primary_button.dart';
import '../utils/app_text_styles.dart';
import 'custom_sized_box.dart';

// ignore: must_be_immutable
class SingleEventWidget extends StatefulWidget {
  SingleEventWidget({super.key, required this.event});

  EventModel event;

  @override
  State<SingleEventWidget> createState() => _SingleEventWidgetState();
}

class _SingleEventWidgetState extends State<SingleEventWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF535990).withOpacity(0.1),
                spreadRadius: 6,
                blurRadius: 6,
                offset: Offset(0, 10.sp),
              )
            ]),
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100.sp,
                width: 100.sp,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.sp),
                    image: DecorationImage(
                        image: NetworkImage(widget.event.pImage),
                        fit: BoxFit.cover)),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, right: 10.w, top: 5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSizeBox(3.h),
                      Text(
                        widget.event.title,
                        style: AppTextStyles.josefin(
                            style: TextStyle(
                                color: const Color(0xFF3A51C8),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500)),
                      ),
                      CustomSizeBox(10.h),
                      Text(
                        widget.event.title,
                        style: AppTextStyles.josefin(
                            style: TextStyle(
                                color: const Color(0xFF120D26),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500)),
                      ),
                      CustomSizeBox(8.h),
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
                              widget.event.address,
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
                      Padding(
                        padding: EdgeInsets.only(right: 60.w),
                        child: GetButton(
                          40.sp,
                          () {
                            Navigator.push(
                              context,
                              PageTransition(
                                childCurrent: widget,
                                type: PageTransitionType.leftToRightWithFade,
                                alignment: Alignment.center,
                                duration: const Duration(milliseconds: 200),
                                reverseDuration:
                                    const Duration(milliseconds: 200),
                                child: CreateEventDetailsView(
                                  event: widget.event,
                                ),
                              ),
                            );
                          },
                          Text(
                            "View Event",
                            style: AppTextStyles.josefin(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
