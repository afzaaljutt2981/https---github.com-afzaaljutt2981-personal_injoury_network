import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/ui/orginizer_profile/view/about_view.dart';
import 'package:personal_injury_networking/ui/orginizer_profile/view/events_view.dart';
import '../../../global/utils/app_text_styles.dart';

class OrgnaizerProfileScreen extends StatefulWidget {
  const OrgnaizerProfileScreen({super.key});

  @override
  State<OrgnaizerProfileScreen> createState() => _OrgnaizerProfileScreenState();
}

class _OrgnaizerProfileScreenState extends State<OrgnaizerProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.more_vert_outlined,
                color: Colors.black,
                size: 22.sp,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          CustomSizeBox(30.h),
          Center(
              child: Image(
            height: 90.sp,
            width: 90.sp,
            image: const AssetImage('assets/images/profile_pic.png'),
          )),
          CustomSizeBox(20.h),
          Text(
            "David  Silbia",
            style: AppTextStyles.josefin(
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
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
                    '350',
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
                    '343',
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
          CustomSizeBox(15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.kPrimaryColor,
                      borderRadius: BorderRadius.circular(7.sp)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 34.w, vertical: 12.h),
                    child: Row(
                      children: [
                        Image(
                          height: 20.sp,
                          width: 20.sp,
                          image: const AssetImage(
                              'assets/images/follow_orgnizer_screen.png'),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Text(
                          'Follow',
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.sp)),
                        ),
                      ],
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
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
                              fontWeight: FontWeight.w600, fontSize: 15.sp)),
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
                ],
              ),
            ),
          ),
          Expanded(
              child: TabBarView(
                  controller: tabController,
                  children: const [OrgnaizerAbout(), OrgnaizerEvents()]))
        ],
      ),
    );
  }
}
