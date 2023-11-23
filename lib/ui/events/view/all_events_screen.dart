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
import '../../authentication/model/user_model.dart';
import '../../create_event/models/event_model.dart';

class AllEventScreen extends StatefulWidget {
  AllEventScreen({super.key, required this.from});

  String from = "";
  @override
  State<AllEventScreen> createState() => _AllEventScreenState();
}

class _AllEventScreenState extends State<AllEventScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  List<EventModel> events = [];
  List<UserModel> users = [];
  List<EventModel> allEvents = [];
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
    users = context.watch<EventsController>().allUsers;
    allEvents = context.watch<EventsController>().allEvents;
    if (FirebaseAuth.instance.currentUser?.email?.toLowerCase() !=
        Constants.adminEmail.toLowerCase()) {
      if(allEvents.isNotEmpty && users.isNotEmpty && FirebaseAuth.instance.currentUser != null){
      var uId = FirebaseAuth.instance.currentUser!.uid;
      UserModel currentUser = users.firstWhere((element) => element.id == uId);
      if(currentUser.userType == "user"){
      List<TicketModel> tickets =
          context.watch<EventsController>().userBookedEvents;
      events = [];
      for (var element in tickets) {
        events.add(allEvents.firstWhere((element1) => element.eId == element1.id));
      }}else{
        events = allEvents.where((element) => element.uId == currentUser.id).toList();
      }
    }} else {
      events = allEvents;
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: widget.from == "1"
              ? Padding(
                  padding: EdgeInsets.all(19.sp),
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
                )
              : SizedBox(),
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
                      "No Events found!",
                      style: AppTextStyles.josefin(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w200)),
                    ),
                  )
                ],
              )
        );
  }
}
