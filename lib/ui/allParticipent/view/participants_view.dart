import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';

import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../../global/utils/constants.dart';
import '../../authentication/model/user_model.dart';
import '../../otherUserProfile/view/create_other_profile_view.dart';

// ignore: must_be_immutable
class AllParticipantsView extends StatefulWidget {
  AllParticipantsView(
      {super.key, required this.users, required this.currentUser});

  List<UserModel?>? users;
  UserModel? currentUser;

  @override
  State<AllParticipantsView> createState() => _AllParticipantsViewState();
}

class _AllParticipantsViewState extends State<AllParticipantsView> {
  @override
  void initState() {
    super.initState();
    setState(() {
      users = widget.users ?? [];
      users?.sort((a, b) => (a?.lastName ?? "").compareTo(b?.lastName ?? ""));
    });
  }

  List<UserModel?>? users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Constants.userType == 'user' ? Colors.white : const Color(0xFFF5F4FF),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSizeBox(Constants.userType == 'user' ? 40.h : 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
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
                Constants.userType == 'user'
                    ? const SizedBox()
                    : Padding(
                        padding: EdgeInsets.only(
                          left: 40.w,
                        ),
                        child: Text(
                          'Registered Users',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.josefin(
                            style: TextStyle(
                                color: const Color(0xFF120D26),
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
              ],
            ),
            CustomSizeBox(25.h),
            Constants.userType == 'user'
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'The Creative Coffee Talks Club',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: AppColors.kPrimaryColor,
                                  fontSize: 26.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          CustomSizeBox(10.h),
                          Text(
                            'Guest List',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: const Color(0xFF857FB4),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomSizeBox(25.h),
                      Text(
                        'No 0f Registered Users : ${users?.length ?? 0}',
                        textAlign: TextAlign.end,
                        style: AppTextStyles.josefin(
                          style: TextStyle(
                              color: const Color(0xFF7A86C3),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      )
                    ],
                  ),
            Expanded(
              child: Constants.userType == 'user'
                  ? GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: users?.length ?? 0,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 80.h,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                childCurrent: widget,
                                type: PageTransitionType.rightToLeft,
                                duration: const Duration(milliseconds: 200),
                                reverseDuration:
                                    const Duration(milliseconds: 200),
                                child: CreateOtherUserProfileView(
                                  participant: users?[index],
                                  currentUser: widget.currentUser,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              if (users?[index]?.pImage != null) ...[
                                CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                    users?[index]?.pImage ?? "",
                                  ),
                                )
                              ] else ...[
                                const CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage(
                                      'assets/images/profile_pic.png'),
                                ),
                                // Container(
                                //   height: 100.sp,
                                //   width: 100.sp,
                                //   decoration: const BoxDecoration(
                                //       // color: Colors.red,
                                //       image: DecorationImage(
                                //           image: AssetImage(
                                //               'assets/images/bc_all_participants_screen.png'),
                                //           fit: BoxFit.contain),
                                //       shape: BoxShape.circle),
                                //   child: Padding(
                                //     padding: EdgeInsets.all(17.sp),
                                //     child: const Image(
                                //       image: AssetImage(
                                //         'assets/images/profile_pic.png',
                                //       ),
                                //       fit: BoxFit.contain,
                                //     ),
                                //   ),
                                // ),
                              ],
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  users?[index]?.userName ?? "",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      color: const Color(0xFF1A1167),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.sp),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: users?.length ?? 0,
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        UserModel? user = users?[index];
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 12.w, right: 12.w, bottom: 10.h),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  childCurrent: widget,
                                  type: PageTransitionType.rightToLeft,
                                  duration: const Duration(milliseconds: 200),
                                  reverseDuration:
                                      const Duration(milliseconds: 200),
                                  child: CreateOtherUserProfileView(
                                    participant: users?[index],
                                    currentUser: users?[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.sp),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 15.h),
                                child: Row(children: [
                                  if (user?.pImage != null) ...[
                                    CircleAvatar(
                                      radius: 23,
                                      backgroundImage: NetworkImage(
                                        user?.pImage ?? "",
                                      ),
                                    )
                                  ] else ...[
                                    Image(
                                        width: 45.sp,
                                        height: 45.sp,
                                        image: const AssetImage(
                                            'assets/images/profile_pic.png'))
                                  ],
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user?.userName ?? "",
                                        style: AppTextStyles.josefin(
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColors.kPrimaryColor,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      CustomSizeBox(5.h),
                                      Text(
                                        user?.userType ?? "",
                                        style: AppTextStyles.josefin(
                                            style: TextStyle(
                                                fontSize: 10.sp,
                                                color: const Color(0xFF857FB4),
                                                fontWeight: FontWeight.w400)),
                                      ),
                                    ],
                                  )
                                ]),
                              ),
                            ),
                          ),
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }
}
