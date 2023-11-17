import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/notifications/controller/notiffications_controller.dart';
import 'package:personal_injury_networking/ui/notifications/model/nitofications_model.dart';
import 'package:provider/provider.dart';

import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../events/controller/events_controller.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<UserModel> allUsers = [];
  List<NotificationsModel> notiList = [];

  String formatDateTime(DateTime dateTime) {
    final dateFormat = DateFormat('E, h:mm a');
    return dateFormat.format(dateTime);
  }

  UserModel? currentUser;

  @override
  Widget build(BuildContext context) {
    notiList = [];
    notiList = context.watch<NotificationsController>().notifications;
    allUsers = context.watch<EventsController>().allUsers;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(8.sp),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: SizedBox(
                width: 40.sp,
                height: 40.sp,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: const Color(0xFF120D26),
                    size: 18.sp,
                  ),
                ),
              ),
            ),
          ),
          title: Center(
            child: Padding(
              padding: EdgeInsets.only(right: 45.w),
              child: Text(
                "Notifications",
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        color: const Color(0xFF120D26),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),
        ),
        body: (allUsers.isEmpty)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : notiList.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomSizeBox(100.h),
                      Center(
                        child: Image(
                          height: 200.sp,
                          width: 250.sp,
                          image: const AssetImage(
                              'assets/images/no_notification_screen.png'),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: notiList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var model = notiList[index];
                                return item(model);
                              })),
                    ],
                  ));
  }

  Widget item(NotificationsModel model) {
    UserModel? user =
        allUsers.firstWhere((element) => element.id == model.senderId);
    currentUser = allUsers.firstWhere(
        (element) => element.id == FirebaseAuth.instance.currentUser!.uid);
    DateTime time = DateTime.fromMillisecondsSinceEpoch(model.time);
    String formattedDate = formatDateTime(time);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
          child: Row(
            // mainAxisAlignment:
            //     MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (user.pImage != null)
                  ? CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(user.pImage!),
                    )
                  : Image(
                      width: 40.sp,
                      image: const AssetImage("assets/images/profile_pic.png")),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        user.lastName,
                        style: AppTextStyles.josefin(
                            style: TextStyle(
                                color: AppColors.kBlackColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500)),
                      ),
                      CustomSizeBox(5.h),
                      Text(
                        "started following you",
                        style: AppTextStyles.josefin(
                            style: TextStyle(fontSize: 12.sp)),
                      ),
                      CustomSizeBox(10.h),
                      if (model.status == "Pending") buttonRow(model, user)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Text(
                  formattedDate,
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          fontSize: 11.sp, color: AppColors.kBlackColor)),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: const Divider(),
        )
      ],
    );
  }

  Widget buttonRow(NotificationsModel model, UserModel user) {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            context
                .read<NotificationsController>()
                .respondRequest(model.id, "Rejected", context);
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFEEEEEE)),
                borderRadius: BorderRadius.circular(7.sp)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 9.h),
              child: Text(
                'Reject',
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        color: const Color(0xFF706D6D), fontSize: 12.sp)),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5.w,
        ),
        GestureDetector(
          onTap: () async {
            await context
                .read<NotificationsController>()
                .respondRequest(model.id, "Accepted", context);
            // ignore: use_build_context_synchronously
            await context
                .read<NotificationsController>()
                .followTap(currentUser!, user.id, context);
            // ignore: use_build_context_synchronously
            await context
                .read<NotificationsController>()
                .followingTap(user, context);
          },
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(7.sp)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 9.h),
              child: Text(
                'Accept',
                style: AppTextStyles.josefin(
                    style: TextStyle(color: Colors.white, fontSize: 12.sp)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
