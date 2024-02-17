import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/utils/constants.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/otherUserProfile/view/create_other_profile_view.dart';

import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_text_styles.dart';

class _ViewUsersState extends State<ViewUsers> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.sp),
              topRight: Radius.circular(30.sp),
            ),
          ),
          child: (widget.allUsers?.isEmpty == true)
              ? const Center(
                  child: Text(
                    "You have no members to show",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomSizeBox(7.h),
                      Center(
                        child: Container(
                          height: 5.h,
                          width: 25.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.sp),
                              color: const Color(0xFFB2B2B2).withOpacity(0.50)),
                        ),
                      ),
                      CustomSizeBox(20.h),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Selected Users',
                              style: AppTextStyles.josefin(
                                  style: TextStyle(
                                      color: const Color(0xFF120D26),
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Text(
                              (widget.allUsers?.length ?? 0).toString(),
                              style: AppTextStyles.josefin(
                                  style: TextStyle(
                                      color: const Color(0xFF120D26),
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ]),
                      CustomSizeBox(10.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFF0F0F0)),
                          borderRadius: BorderRadius.circular(25.sp),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                          ),
                          if (widget.allUsers?.isEmpty == true) ...[
                            const Padding(
                              padding: EdgeInsets.only(top: 18.0),
                              child: Center(child: Text("No User Found")),
                            )
                          ] else ...[
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: widget.allUsers?.length ?? 0,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return friend(widget.allUsers?[index]);
                                    }))
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget friend(UserModel? friend) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
      child: GestureDetector(
        onTap: FirebaseAuth.instance.currentUser?.email?.toLowerCase() ==
                Constants.adminEmail.toLowerCase()
            ? null
            : () {
                print("clicked");
                Navigator.push(
                  context,
                  PageTransition(
                    childCurrent: widget,
                    type: PageTransitionType.rightToLeft,
                    alignment: Alignment.center,
                    duration: const Duration(milliseconds: 200),
                    reverseDuration: const Duration(milliseconds: 200),
                    child: CreateOtherUserProfileView(
                      participant: friend,
                      currentUser: widget.currentUser,
                    ),
                  ),
                );
              },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (friend?.pImage != null) ...[
              CircleAvatar(
                backgroundImage: NetworkImage(friend?.pImage ?? ""),
                radius: 23,
              )
            ] else ...[
              Image(
                image: const AssetImage('assets/images/profile_pic.png'),
                width: 45.sp,
                height: 45.sp,
              ),
            ],
            SizedBox(
              width: 10.w,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (friend?.firstName ?? "") + " " + (friend?.lastName ?? ""),
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          color: const Color(0xFF120D26),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500)),
                ),
                CustomSizeBox(5.h),
                Text(
                  '${friend?.followers?.length ?? 0} Followers',
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          color: const Color(0xFF747688),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400)),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}

class ViewUsers extends StatefulWidget {
  ViewUsers({super.key, required this.allUsers, required this.currentUser});

  List<UserModel?>? allUsers;
  UserModel? currentUser;

  @override
  State<ViewUsers> createState() => _ViewUsersState();
}
