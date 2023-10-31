import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_type.dart';

import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../../global/utils/constants.dart';
import '../model/events_history_model.dart';

class OtherUserReviewScreen extends StatefulWidget {
  const OtherUserReviewScreen({super.key});

  @override
  State<OtherUserReviewScreen> createState() => _OtherUserReviewScreenState();
}

List<EventHistoryModel> eventsReviewList = [
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

class _OtherUserReviewScreenState extends State<OtherUserReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return eventsReviewList.isEmpty
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
                'No Reviews History',
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
            itemCount: eventsReviewList.length,
            itemBuilder: (context, index) {
              var model = eventsReviewList[index];
              return Constants.userType == 'user'
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
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
                                        image: AssetImage(model.image),
                                        fit: BoxFit.cover)),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.w, right: 10.w, top: 20.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        model.time,
                                        style: AppTextStyles.josefin(
                                            style: TextStyle(
                                                color: const Color(0xFF212E73),
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      CustomSizeBox(10.h),
                                      Text(
                                        model.eventName,
                                        style: AppTextStyles.josefin(
                                            style: TextStyle(
                                                color: const Color(0xFF120D26),
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      CustomSizeBox(5.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
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
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Column(
                        children: [
                          CustomSizeBox(20.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image(
                                image: const AssetImage(
                                    'assets/images/profile_pic.png'),
                                width: 40.sp,
                                height: 40.sp,
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Expanded(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                          text: 'Rocks Velkeinjen rated ',
                                          style: AppTextStyles.josefin(
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.w400))),
                                      TextSpan(
                                          text: '4.3 Star',
                                          style: AppTextStyles.josefin(
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xFFF9E534),
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.w600))),
                                      TextSpan(
                                          text: ' to',
                                          style: AppTextStyles.josefin(
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.w400))),
                                      TextSpan(
                                          text: ' EVENTNAME',
                                          style: AppTextStyles.josefin(
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  height: 1.5.sp,
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.w700))),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 7.h),
                                child: Text(
                                  '10 Feb',
                                  style: AppTextStyles.josefin(
                                      style: TextStyle(
                                          color: const Color(0xFFADAFBB),
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400)),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 7.h, bottom: 15.h, right: 5.w, left: 5.w),
                            child: Text(
                              'Cinemas is the ultimate experience to see new movies in Gold Class or Vmax. Find a cinema near you.',
                              style: AppTextStyles.josefin(
                                  style: TextStyle(
                                      height: 1.3.sp,
                                      color: const Color(0xFF645D5D),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400)),
                            ),
                          )
                        ],
                      ),
                    );
            });
  }
}
