import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/events/controller/events_controller.dart';
import 'package:personal_injury_networking/ui/otherUserProfile/controller/other_user_profile_controller.dart';
import 'package:personal_injury_networking/ui/otherUserProfile/view/about_view.dart';
import 'package:personal_injury_networking/ui/otherUserProfile/view/events_view.dart';
import 'package:personal_injury_networking/ui/otherUserProfile/view/reviews_view.dart';
import 'package:provider/provider.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../create_event/models/event_model.dart';
import '../../events_details/models/ticket_model.dart';

class OtherUserProfileScreen extends StatefulWidget {
  OtherUserProfileScreen({super.key, required this.user});
  UserModel user;
  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  bool isFollow = false;
  UserModel? user;
  List<EventModel> userEvents = [];
  List<TicketModel> userTickets = [];
  @override
  Widget build(BuildContext context) {
    List<EventModel> allEvents = Provider.of<EventsController>(context,listen: false).allEvents;
    user = context.watch<OtherUserProfileController>().userModel;
    userTickets = context.watch<OtherUserProfileController>().userTickets;
    if(allEvents.isNotEmpty){
    for (var element in userTickets) {
      for (var element1 in allEvents) {
        if(element1.id == element.eId){
          userEvents.add(element1);
        }
      }
    }}
    if(user != null){
    if(user!.followers.contains(FirebaseAuth.instance.currentUser!.uid)){
      isFollow = true;
    }}
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
      ),
      body: (user != null)
          ? Column(
              children: [
                CustomSizeBox(10.h),
                if (user!.pImage == null) ...[
                  Center(
                      child: Image(
                    height: 90.sp,
                    width: 90.sp,
                    image: const AssetImage('assets/images/profile_pic.png'),
                  ))
                ] else ...[
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(user!.pImage!),
                  )
                ],
                CustomSizeBox(20.h),
                Text(
                  user!.userName,
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600)),
                ),
                CustomSizeBox(20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user!.followings.length.toString(),
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF120D26))),
                        ),
                        CustomSizeBox(5.h),
                        Text(
                          'Following',
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF747688))),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                      child: Container(
                        width: 1.w,
                        height: 30.h,
                        color: const Color(0xFFDDDDDD),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user!.followers.length.toString(),
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF120D26))),
                        ),
                        CustomSizeBox(5.h),
                        Text(
                          'Followers',
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF747688))),
                        )
                      ],
                    ),
                  ],
                ),
                if(user!.id != FirebaseAuth.instance.currentUser!.uid)
                Column(
                  children: [
                    CustomSizeBox(15.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                context.read<OtherUserProfileController>().followTap(
                                  user!,
                                  user!.id,
                                );

                                context.read<OtherUserProfileController>().followingTap(
                                 user!,
                                  FirebaseAuth.instance.currentUser!.uid,
                                );
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.kPrimaryColor,
                                  borderRadius: BorderRadius.circular(7.sp)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: isFollow == false ? 34.w : 23.w,
                                    vertical: 12.h),
                                child: Row(
                                  children: [
                                    isFollow == false
                                        ? Image(
                                            height: 20.sp,
                                            width: 20.sp,
                                            image: const AssetImage(
                                                'assets/images/follow_orgnizer_screen.png'),
                                          )
                                        : Image(
                                            height: 20.sp,
                                            width: 20.sp,
                                            image: const AssetImage(
                                                'assets/images/followed_other_user.png'),
                                          ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    Text(
                                      isFollow ? 'Followed ' : 'Follow',
                                      style: AppTextStyles.josefin(
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.kPrimaryColor, width: 1.5.sp),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(7.sp)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.w, vertical: 10.h),
                              child: Row(
                                children: [
                                  Image(
                                    height: 20.sp,
                                    width: 20.sp,
                                    image: const AssetImage(
                                        'assets/images/message_orgnizer_screen.png'),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    'Messages',
                                    style: AppTextStyles.josefin(
                                        style: TextStyle(
                                            color: AppColors.kPrimaryColor,
                                            fontSize: 16.sp)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomSizeBox(20.h),
                  ],
                ),
                SizedBox(
                  height: 45.h,
                  child: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    bottom: TabBar(
                      unselectedLabelColor: Colors.grey,
                      labelColor: AppColors.kPrimaryColor,
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: AppColors.kPrimaryColor,
                      indicatorWeight: 2.sp,
                      tabs: [
                        Tab(
                          child: Text(
                            'ABOUT',
                            style: AppTextStyles.josefin(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp)),
                            textScaleFactor: 1,
                          ),
                        ),
                        Tab(
                          child: Text(
                            'EVENT',
                            style: AppTextStyles.josefin(),
                            textScaleFactor: 1,
                          ),
                        ),
                        Tab(
                          child: Text(
                            'REVIEWS',
                            style: AppTextStyles.josefin(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp)),
                            textScaleFactor: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: TabBarView(
                        controller: tabController,
                        children:  [
                      OrganizerAbout(user: user!,),
                      OrganizerEvents(userEvents : userEvents),
                      const OtherUserReviewScreen()
                    ]))
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
