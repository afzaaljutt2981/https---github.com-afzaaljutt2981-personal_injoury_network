import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/constants.dart';
import 'package:personal_injury_networking/ui/create_event/view/add_event_view.dart';
import 'package:personal_injury_networking/ui/events/controller/events_controller.dart';
import 'package:personal_injury_networking/ui/events/view/past_events.dart';
import 'package:personal_injury_networking/ui/events/view/up_coming_events.dart';
import 'package:personal_injury_networking/ui/events_details/models/ticket_model.dart';
import 'package:provider/provider.dart';

import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../create_event/models/event_model.dart';
import '../model/all_events_model.dart';

class AllEventScreen extends StatefulWidget {
  const AllEventScreen({super.key});

  @override
  State<AllEventScreen> createState() => _AllEventScreenState();
}

class _AllEventScreenState extends State<AllEventScreen>
    with SingleTickerProviderStateMixin {
  List<AllEventsModel> allEventsList = [
    AllEventsModel(
        'assets/images/intro_background_image.png',
        'A virtual evening of smooth jazz',
        '1st  May- Sat -2:00 PM',
        'Radius Gallery • Santa Cruz, CA'),
    AllEventsModel(
        'assets/images/intro_background_image.png',
        'Jo malone london’s mother’s day ',
        '1st  May- Sat -2:00 PM',
        'Lot 13 • Oakland, CA'),
    AllEventsModel(
        'assets/images/intro_background_image.png',
        "Women's leadership conference",
        '1st  May- Sat -2:00 PM',
        '53 Bush St • San Francisco, CA'),
    AllEventsModel(
        'assets/images/intro_background_image.png',
        'International kids safe parents night out',
        '1st  May- Sat -2:00 PM',
        'Lot 13 • Oakland, CA'),
    AllEventsModel(
        'assets/images/intro_background_image.png',
        'International gala music festival',
        '1st  May- Sat -2:00 PM',
        'Longboard Margarita Bar '),
  ];
  late TabController tabController;
  List<EventModel> events = [];
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Constants.userType == "user") {
      List<TicketModel> tickets =
          context.watch<EventsController>().userBookedEvents;
      tickets.forEach((element) {
        events.add(context
            .watch<EventsController>()
            .allEvents
            .firstWhere((element1) => element.eId == element1.id));
      });
    } else {
      events = context.watch<EventsController>().allEvents;
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          // leading: Padding(
          //   padding: EdgeInsets.all(19.sp),
          //   child: GestureDetector(
          //     onTap: () => Navigator.pop(context),
          //     child: Image(
          //       height: 10.sp,
          //       width: 10.sp,
          //       image: const AssetImage('assets/images/back_arrow_events.png'),
          //     ),
          //   ),
          // ),
          title: Center(
            child: Text(
              "All Events",
              style: AppTextStyles.josefin(
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.kPrimaryColor)),
            ),
          ),
          // actions: [
          //   allEventsList.isEmpty
          //       ? const SizedBox()
          //       : Image(
          //           height: 18.sp,
          //           width: 18.sp,
          //           image: const AssetImage('assets/images/search_icon.png'),
          //         ),
          //   Padding(
          //     padding: EdgeInsets.only(right: 20.w, left: 10.w),
          //     child: GestureDetector(
          //       onTap: () {
          //         Navigator.push(
          //           context,
          //           PageTransition(
          //             childCurrent: widget,
          //             type: PageTransitionType.rightToLeft,
          //             alignment: Alignment.center,
          //             duration: const Duration(milliseconds: 200),
          //             reverseDuration: const Duration(milliseconds: 200),
          //             child: const AddEventView(),
          //           ),
          //         );
          //       },
          //       child: Icon(
          //         Icons.more_vert_outlined,
          //         color: Colors.black,
          //         size: 22.sp,
          //       ),
          //     ),
          //   ),
          // ],
        ),
        body: events.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          var model = events[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 8.h),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.sp),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF535990)
                                          .withOpacity(0.1),
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
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          image: DecorationImage(
                                              image: NetworkImage(model.pImage),
                                              fit: BoxFit.cover)),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.w, right: 10.w, top: 5.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomSizeBox(3.h),
                                            Text(
                                              model.title,
                                              style: AppTextStyles.josefin(
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xFF3A51C8),
                                                      fontSize: 13.sp,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            CustomSizeBox(10.h),
                                            Text(
                                              model.title,
                                              style: AppTextStyles.josefin(
                                                  style: TextStyle(
                                                      color: const Color(
                                                          0xFF120D26),
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w500)),
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
                                                    model.address,
                                                    style: AppTextStyles.josefin(
                                                        style: TextStyle(
                                                            color: const Color(
                                                                0xFF747688),
                                                            fontSize: 11.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
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
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              )
            : SizedBox(
                //  height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    CustomSizeBox(20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Container(
                        // height: 50,
                        width: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.0687),
                            borderRadius: BorderRadius.circular(40.sp)),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10.w,
                                  right: 10.w,
                                  top: 6.h,
                                  bottom: 6.h),
                              child: TabBar(
                                unselectedLabelColor: const Color(0xFF9B9B9B),
                                labelColor: const Color(0xFF5669FF),
                                indicatorColor: Colors.white,
                                indicatorWeight: 2,
                                indicator: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF535990)
                                          .withOpacity(0.1),
                                      spreadRadius: 6,
                                      blurRadius: 6,
                                      offset: Offset(0, 8.sp),
                                    )
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40.sp),
                                ),
                                controller: tabController,
                                tabs: [
                                  Tab(
                                    child: Text(
                                      'UP COMING',
                                      style: AppTextStyles.josefin(
                                          style: TextStyle(fontSize: 14.sp)),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'PAST EVENTS',
                                      style: AppTextStyles.josefin(
                                          style: TextStyle(fontSize: 14.sp)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: const [
                          UpComingEvents(),
                          PastEvents(),
                        ],
                      ),
                    )
                  ],
                ),
              ));
  }
}
