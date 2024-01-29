import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/ui/compaign/models/campaign_model.dart';
import 'package:personal_injury_networking/ui/compaign/view/create_compaign_view.dart';
import 'package:provider/provider.dart';

import '../../../../global/helper/custom_sized_box.dart';
import '../../../../global/utils/app_colors.dart';
import '../../../../global/utils/app_text_styles.dart';
import '../controller/allCreatedCapaignsController.dart';

class AllCreatedCampaignsScreen extends StatefulWidget {
  const AllCreatedCampaignsScreen({super.key});

  @override
  State<AllCreatedCampaignsScreen> createState() =>
      _AllCreatedCampaignsScreen();
}

class _AllCreatedCampaignsScreen extends State<AllCreatedCampaignsScreen> {
  List<CampaignModel> allCampaigns = [];

  @override
  Widget build(BuildContext context) {
    allCampaigns = context.watch<AllCreatedCampaignsController>().allCampaigns;
    return Scaffold(
        backgroundColor: const Color(0xFFf5f4ff),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
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
          ),
          title: Center(
            child: Padding(
              padding: EdgeInsets.only(right: 45.w),
              child: Text(
                "All Created Campaigns",
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        color: const Color(0xFF120D26),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),
        ),
        body: allCampaigns.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: allCampaigns.length,
                        itemBuilder: (context, index) {
                          var model = allCampaigns[index];
                          return
                            Padding(
                            padding: EdgeInsets.only(
                                left: 15.w, right: 15.w, bottom: 10.h),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.sp),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Row(children: [
                                  Container(
                                    height: 70.sp,
                                    width: 70.sp,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(20.sp),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                model?.pImage ?? ""),
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Campaign created for people of ${model.country} doing job as ${model.jobOrPosition}",
                                            style: AppTextStyles.josefin(
                                                style: TextStyle(
                                                    color:
                                                        AppColors.kBlackColor,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                          CustomSizeBox(5.h),
                                          buttonRow(model)
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              )
            : Center(
                child: Text("No user found"),
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                childCurrent: widget,
                type: PageTransitionType.leftToRight,
                duration: const Duration(milliseconds: 200),
                reverseDuration: const Duration(milliseconds: 200),
                child: const CreateCampaignView(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ));
  }

  Widget buttonRow(CampaignModel model) {
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
                  await context
                      .read<AllCreatedCampaignsController>()
                      .initiateCampaign(campaign: model, context);
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
}
