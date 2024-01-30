import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/compaign/models/campaign_model.dart';
import 'package:personal_injury_networking/ui/notifications/controller/notiffications_controller.dart';
import 'package:personal_injury_networking/ui/notifications/model/nitofications_model.dart';
import 'package:provider/provider.dart';

import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../events/controller/events_controller.dart';
import '../model/generic_data_model.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<UserModel> allUsers = [];
  List<NotificationsModel> notiList = [];
  List<CampaignModel> allCampaigns = [];
  List<GenericDataModel> allNotificationsAndCampaigns = [];

  String formatDateTime(DateTime dateTime) {
    final dateFormat = DateFormat('E, h:mm a');
    return dateFormat.format(dateTime);
  }

  UserModel? currentUser;

  @override
  Widget build(BuildContext context) {
    print(currentUser);
    notiList = [];
    notiList = context.watch<NotificationsController>().notifications;
    allCampaigns = context.watch<NotificationsController>().allCampaigns;
    allUsers = context.watch<EventsController>().allUsers;
    currentUser = allUsers.firstWhere(
        (element) => element.id == FirebaseAuth.instance.currentUser!.uid);
    allNotificationsAndCampaigns = notiList
        .map((e) => GenericDataModel(
            notificationsModel: e, campaignModel: null, notificationType: "N"))
        .toList()
      ..addAll(allCampaigns
          .where((element) =>
              element.status == "Completed" &&
              element.country == currentUser?.country &&
              element.jobOrPosition == currentUser?.position)
          .toList()
          .map((campaign) => GenericDataModel(
              notificationsModel: null,
              campaignModel: campaign,
              notificationType: "C"))
          .toList());
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
            : allNotificationsAndCampaigns.isEmpty
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
                              itemCount: allNotificationsAndCampaigns.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var model = allNotificationsAndCampaigns[index];
                                return model.notificationType == "N"
                                    ? item(model.notificationsModel!)
                                    : campaignItem(model.campaignModel!);
                              })),
                    ],
                  ));
  }

  Widget item(NotificationsModel model) {
    UserModel? user =
        allUsers.firstWhere((element) => element.id == model.senderId);
    currentUser = allUsers.firstWhere(
        (element) => element.id == FirebaseAuth.instance.currentUser!.uid);
    DateTime time = DateTime.fromMillisecondsSinceEpoch(model.time ?? 0);
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
                        user.lastName ?? "",
                        style: AppTextStyles.josefin(
                            style: TextStyle(
                                color: AppColors.kBlackColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500)),
                      ),
                      CustomSizeBox(5.h),
                      if (model.notificationType == "Follow") ...[
                        Text(
                          "started following you",
                          style: AppTextStyles.josefin(
                              style: TextStyle(fontSize: 12.sp)),
                        )
                      ] else ...[
                        Text(model.notificationContent!)
                      ],
                      CustomSizeBox(10.h),
                      if (model.status == "Pending" &&
                          model.notificationType == "Follow")
                        buttonRow(model, user)
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
                .respondRequest(model.id ?? "", "Rejected", context);
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
                .respondRequest(model.id ?? "", "Accepted", context);
            // ignore: use_build_context_synchronously
            await context
                .read<NotificationsController>()
                .followTap(currentUser, user.id ?? "", context);
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

  Widget campaignButtonRow(CampaignModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () async {
            // context
            //     .read<NotificationsController>()
            //     .respondRequest(model.id ?? "", "Rejected", context);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(
                  'Target Users: ',
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          color: AppColors.kBlackColor, fontSize: 12.sp)),
                ),
                Text(
                  '${model.members?.length ?? ""}',
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          color: AppColors.kgreenColor, fontSize: 12.sp)),
                ),
              ]),
              SizedBox(
                height: 5.sp,
              ),
              Row(children: [
                Text(
                  'Status: ',
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          color: AppColors.kBlackColor, fontSize: 12.sp)),
                ),
                Text(
                  '${model.status}',
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          color: AppColors.kgreenColor, fontSize: 12.sp)),
                ),
              ])
            ],
          ),
        ),
        SizedBox(
          height: 5.h,
        ),
        GestureDetector(
          onTap: (model.members?.length ?? 0) > 0 && model.status != "Completed"
              ? () async {
                  print("Button clicked..");
                  // await context
                  //     .read<AllCreatedCampaignsController>()
                  //     .initiateCampaign(campaign: model, context);
                  // // ignore: use_build_context_synchronously
                  // await context
                  //     .read<NotificationsController>()
                  //     .followTap(currentUser, user.id ?? "", context);
                  // // ignore: use_build_context_synchronously
                  // await context
                  //     .read<NotificationsController>()
                  //     .followingTap(user, context);
                }
              : null,
          child: Container(
            decoration: BoxDecoration(
                color: (model.members?.length ?? 0) > 0 &&
                        model.status != "Completed"
                    ? AppColors.kPrimaryColor
                    : AppColors.dashedBorderColor,
                borderRadius: BorderRadius.circular(7.sp)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 9.h),
              child: Text(
                'Initiate',
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        color: (model.members?.length ?? 0) > 0 &&
                                model.status != "Completed"
                            ? Colors.white
                            : Colors.black,
                        fontSize: 12.sp)),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget campaignItem(CampaignModel model) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Row(children: [
                Container(
                  height: 70.sp,
                  width: 70.sp,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20.sp),
                      image: DecorationImage(
                          image: NetworkImage(model?.pImage ?? ""),
                          fit: BoxFit.cover)),
                ),
                // Image(
                //     width: 50.sp,
                //     height: 50.sp,
                //     image: const AssetImage(
                //         'assets/images/profile_pic.png')),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Campaign created for people of ${model.country} doing job as ${model.jobOrPosition}",
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: AppColors.kBlackColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500)),
                        ),
                        CustomSizeBox(5.h),
                        campaignButtonRow(model)
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: const Divider(),
        )
      ],
    );
  }
}
