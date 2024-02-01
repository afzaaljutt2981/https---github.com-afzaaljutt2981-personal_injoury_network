import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';
import 'package:personal_injury_networking/ui/myProfile/controller/my_profile_controller.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../global/helper/custom_sized_box.dart';
import '../../authentication/model/user_model.dart';

class HomeQrScanView extends StatefulWidget {
  HomeQrScanView({super.key, required this.from});

  String from = "";

  @override
  State<HomeQrScanView> createState() => _HomeQrScanViewState();
}

class _HomeQrScanViewState extends State<HomeQrScanView> {
  UserModel? user;

  @override
  Widget build(BuildContext context) {
    user = context.watch<MyProfileController>().user;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      appBar: widget.from == "1"
          ? AppBar(
              backgroundColor: AppColors.kPrimaryColor,
              elevation: 0,
              leading: Padding(
                padding: EdgeInsets.all(10.sp),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SizedBox(
                    width: 30.sp,
                    height: 40.sp,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.kWhiteColor,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
              title: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: 45.w),
                  child: Text(
                    "Create Event",
                    style: AppTextStyles.josefin(
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
            )
          : null,
      body: (user != null)
          ? SingleChildScrollView(
              child: Column(
                children: [
                  CustomSizeBox(65.h),
                  Center(
                    child: Image(
                      height: 60.sp,
                      width: 60.sp,
                      image: const AssetImage('assets/images/primary_icon.png'),
                    ),
                  ),

                  CustomSizeBox(30.h),
                  // Stack
                  Stack(
                    children: [
                      //  Container
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 45.h),
                          child: Container(
                            width: 290.w,
                            height: 300.h,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),

                            //  Container Data
                            child: Padding(
                              padding: const EdgeInsets.only(left: 9, right: 9),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomSizeBox(50.h),
                                  Text(
                                    user?.firstName ?? 'Q/A',
                                    style: AppTextStyles.josefin(
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  CustomSizeBox(5.h),
                                  Text(
                                    user?.position ?? 'Q/A',
                                    style: AppTextStyles.josefin(
                                        style: TextStyle(
                                      color: const Color(0xFFA1A1A1),
                                      fontSize: 12.sp,
                                    )),
                                  ),
                                  CustomSizeBox(15.h),
                                  QrImage(
                                    foregroundColor: AppColors.kPrimaryColor,
                                    data: FirebaseAuth.instance.currentUser?.uid
                                            .toString() ??
                                        'Q/A',
                                    version: QrVersions.auto,
                                    size: 180.sp,
                                    gapless: false,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (user?.pImage == null) ...[
                        Positioned(
                          top: screenHeight * 0.01,
                          left: screenWidth * 0.38,
                          // child: if (user?.pImage == null) ...[
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Image(
                              height: 80.sp,
                              width: 80.sp,
                              image: const AssetImage(
                                  'assets/images/profile_pic.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ] else ...[
                        Positioned(
                          top: screenHeight * 0.01,
                          left: screenWidth * 0.38,
                          child: CircleAvatar(
                            radius: 40.sp,
                            backgroundImage: NetworkImage(
                              user?.pImage ?? '',
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
