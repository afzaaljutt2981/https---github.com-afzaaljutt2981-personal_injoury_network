import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/helper/single_event_widget.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/constants.dart';
import 'package:personal_injury_networking/ui/events/controller/events_controller.dart';
import 'package:personal_injury_networking/ui/events_details/models/ticket_model.dart';
import 'package:provider/provider.dart';

import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../create_event/models/event_model.dart';

class AllEventScreen extends StatefulWidget {
  const AllEventScreen({super.key});

  @override
  State<AllEventScreen> createState() => _AllEventScreenState();
}

class _AllEventScreenState extends State<AllEventScreen>
    with SingleTickerProviderStateMixin {
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
    if (FirebaseAuth.instance.currentUser?.email?.toLowerCase() !=
        Constants.adminEmail.toLowerCase()) {
      List<TicketModel> tickets =
          context.watch<EventsController>().userBookedEvents;
      events = [];
      for (var element in tickets) {
        events.add(context
            .watch<EventsController>()
            .allEvents
            .firstWhere((element1) => element.eId == element1.id));
      }
    } else {
      events = context.watch<EventsController>().allEvents;
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
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
        ),
        body: events.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          var model = events[index];
                          return SingleEventWidget(event: model);
                        }),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "No Events found",
                      style: AppTextStyles.josefin(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w200)),
                    ),
                  )
                ],
              )

        // SizedBox(
        //         //  height: MediaQuery.of(context).size.height,
        //         child: Column(
        //           children: [
        //             CustomSizeBox(20.h),
        //             Padding(
        //               padding: EdgeInsets.symmetric(horizontal: 25.w),
        //               child: Container(
        //                 // height: 50,
        //                 width: MediaQuery.of(context).size.height,
        //                 decoration: BoxDecoration(
        //                     color: Colors.black.withOpacity(0.0687),
        //                     borderRadius: BorderRadius.circular(40.sp)),
        //                 child: Column(
        //                   children: [
        //                     Padding(
        //                       padding: EdgeInsets.only(
        //                           left: 10.w,
        //                           right: 10.w,
        //                           top: 6.h,
        //                           bottom: 6.h),
        //                       child: TabBar(
        //                         unselectedLabelColor: const Color(0xFF9B9B9B),
        //                         labelColor: const Color(0xFF5669FF),
        //                         indicatorColor: Colors.white,
        //                         indicatorWeight: 2,
        //                         indicator: BoxDecoration(
        //                           boxShadow: [
        //                             BoxShadow(
        //                               color: const Color(0xFF535990)
        //                                   .withOpacity(0.1),
        //                               spreadRadius: 6,
        //                               blurRadius: 6,
        //                               offset: Offset(0, 8.sp),
        //                             )
        //                           ],
        //                           color: Colors.white,
        //                           borderRadius: BorderRadius.circular(40.sp),
        //                         ),
        //                         controller: tabController,
        //                         tabs: [
        //                           Tab(
        //                             child: Text(
        //                               'UP COMING',
        //                               style: AppTextStyles.josefin(
        //                                   style: TextStyle(fontSize: 14.sp)),
        //                             ),
        //                           ),
        //                           Tab(
        //                             child: Text(
        //                               'PAST EVENTS',
        //                               style: AppTextStyles.josefin(
        //                                   style: TextStyle(fontSize: 14.sp)),
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //             Expanded(
        //               child: TabBarView(
        //                 controller: tabController,
        //                 children: const [
        //                   UpComingEvents(),
        //                   PastEvents(),
        //                 ],
        //               ),
        //             )
        //           ],
        //         ),
        //       )
        );
  }
}
