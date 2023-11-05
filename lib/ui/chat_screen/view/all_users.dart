import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/ui/chat_screen/view/chat_view.dart';

import '../../../global/utils/app_text_styles.dart';
import '../model/chat_model.dart';

class AllUsersChat extends StatefulWidget {
  const AllUsersChat({super.key});

  @override
  State<AllUsersChat> createState() => _AllUsersChatState();
}

class _AllUsersChatState extends State<AllUsersChat> {
  List<ChatUsers> chatUsers = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFf5f4ff),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: const Color(0xFFf5f4ff),
              child: Padding(
                padding: EdgeInsets.only(top: 50.h, bottom: 15.h),
                child: Center(
                  child: Text(
                    'Messages',
                    style: AppTextStyles.josefin(
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.kBlackColor)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.sp),
                        topRight: Radius.circular(30.sp))),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   PageTransition(
                          //     childCurrent: widget,
                          //     type: PageTransitionType.rightToLeftJoined,
                          //     alignment: Alignment.center,
                          //     duration: const Duration(milliseconds: 200),
                          //     reverseDuration:
                          //         const Duration(milliseconds: 200),
                          //     child: const ChatScreen(),
                          //   ),
                          // );
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 15.w, right: 15.w, top: 14.h, bottom: 8.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage: const AssetImage(
                                          'assets/images/profile_pic.png'),
                                      maxRadius: 26.sp,
                                    ),
                                    SizedBox(
                                      width: 16.sp,
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Michael',
                                              style: AppTextStyles.josefin(
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: const Color(
                                                          0xFF1A1167),
                                                      fontSize: 12.sp)),
                                            ),
                                            CustomSizeBox(6.h),
                                            Text(
                                              'Would you rather humans go to the moon again or go to mars?',
                                              style: AppTextStyles.josefin(
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: const Color(
                                                          0xFF857FB4),
                                                      fontSize: 11.sp)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: Text(
                                  'Just now',
                                  style: AppTextStyles.josefin(
                                      style: TextStyle(
                                          color: const Color(0xFF857FB4),
                                          fontSize: 10.sp)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}
