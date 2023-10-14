import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../otherUserProfile/model/events_history_model.dart';

class SearchEventScreen extends StatefulWidget {
  const SearchEventScreen({super.key});

  @override
  State<SearchEventScreen> createState() => _SearchEventScreenState();
}

TextEditingController searchcontroller = TextEditingController();
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

class _SearchEventScreenState extends State<SearchEventScreen> {
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
            child: Image(
              height: 10.sp,
              width: 10.sp,
              image: const AssetImage('assets/images/back_arrow_events.png'),
            ),
          ),
        ),
        title: Text(
          "Search",
          style: AppTextStyles.josefin(
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF120D26))),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF535990).withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 2,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.sp),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 0.w),
                              child: Image(
                                height: 18.sp,
                                width: 18.sp,
                                image: const AssetImage(
                                    'assets/images/search_icon.png'),
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Container(
                              width: 2.w,
                              height: 20.h,
                              color: AppColors.kPrimaryColor,
                            ),
                            SizedBox(
                              width: 0.w,
                            ),
                            SizedBox(
                              width: 200.w,
                              child: TextFormField(
                                controller: searchcontroller,

                                maxLines: 1,

                                //  controller: controller,
                                style: AppTextStyles.josefin(
                                    style: TextStyle(
                                        color: const Color(0xFF1F314A),
                                        fontSize: 16.sp)),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 12.w),
                                    border: InputBorder.none,
                                    hintText: "Search...",
                                    hintStyle: AppTextStyles.josefin(
                                        style: TextStyle(
                                            color: const Color(0xFF1F314A)
                                                .withOpacity(0.40),
                                            fontSize: 16.sp))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Image(
                  height: 60.sp,
                  width: 60.sp,
                  image:
                      const AssetImage('assets/images/filter_search_event.png'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: eventsHistoryList.length,
                itemBuilder: (context, index) {
                  var model = eventsHistoryList[index];
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
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
                                      image: AssetImage(model.image),
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
                                    CustomSizeBox(3.h),
                                    Text(
                                      model.time,
                                      style: AppTextStyles.josefin(
                                          style: TextStyle(
                                              color: const Color(0xFF212E73),
                                              fontSize: 13.sp,
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
                                    CustomSizeBox(3.h),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
