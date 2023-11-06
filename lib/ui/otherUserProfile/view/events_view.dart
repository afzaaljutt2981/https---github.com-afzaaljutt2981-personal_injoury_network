import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_type.dart';
import 'package:personal_injury_networking/ui/create_event/models/event_model.dart';

import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../../global/utils/constants.dart';
import '../model/events_history_model.dart';

class OrganizerEvents extends StatelessWidget {
  List<EventModel> userEvents;

  OrganizerEvents({super.key, required this.userEvents});

  @override
  Widget build(BuildContext context) {
    return userEvents.isEmpty
        ? Column(
            children: [
              CustomSizeBox(30.h),
              Image(
                  height: 100.sp,
                  width: 100.sp,
                  image: const AssetImage(
                      'assets/images/no_history_orgnaizer_event.png')),
              CustomSizeBox(14.h),
              Text(
                'No events history',
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        color: const Color(0xFF120D26),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: userEvents.length,
            itemBuilder: (context, index) {
              var model = eventsHistoryList[index];
              return eventBox(userEvents[index]);
            });
  }

  Widget eventBox(EventModel event){
    DateTime date = DateTime.fromMillisecondsSinceEpoch(event.dateTime);
    String fDate = DateFormat("d MMM- EEEE").format(date);
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(event.startTime);
    String fStartTime = DateFormat("HH:mm a").format(startTime);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.sp),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF535990).withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 2,
                // offset: Offset(0, 1.sp),
              )
            ]),
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 110.sp,
                width: 100.sp,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20.sp),
                    image: DecorationImage(
                        image: NetworkImage(event.pImage),
                        fit: BoxFit.cover)),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 20.w, right: 10.w, top: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "$fDate- $fStartTime",
                        style: AppTextStyles.josefin(
                            style: TextStyle(
                                color: const Color(0xFF212E73),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500)),
                      ),
                      CustomSizeBox(10.h),
                      Text(
                        event.title,
                        style: AppTextStyles.josefin(
                            style: TextStyle(
                                color: const Color(0xFF120D26),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500)),
                      ),
                      Constants.userType == 'user'
                          ? const SizedBox()
                          : Row(
                        mainAxisAlignment:
                        MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF0AFF31)
                                  .withOpacity(0.24),
                              borderRadius:
                              BorderRadius.circular(20.sp),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Text(
                                'Upcoming',
                                style: AppTextStyles.josefin(
                                    style: TextStyle(
                                        color: const Color(
                                            0xFF17DF1F),
                                        fontSize: 12.sp)),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<EventHistoryModel> eventsHistoryList = [
  EventHistoryModel('assets/images/intro_background_image.png',
      'A virtual evening of smooth jazz', '1st  May- Sat -2:00 PM'),
  EventHistoryModel('assets/images/intro_background_image.png',
      'Jo malone london’s mother’s day ', '1st  May- Sat -2:00 PM'),
  EventHistoryModel('assets/images/intro_background_image.png',
      "Women's leadership conference", '1st  May- Sat -2:00 PM'),
  EventHistoryModel('assets/images/intro_background_image.png',
      'International kids safe parents night out', '1st  May- Sat -2:00 PM'),
  EventHistoryModel('assets/images/intro_background_image.png',
      'International gala music festival', '1st  May- Sat -2:00 PM'),
];
