import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/ui/chat_screen/controller/user_chat_data.dart';
import 'package:personal_injury_networking/ui/chat_screen/model/chat_data.dart';
import 'package:personal_injury_networking/ui/chat_screen/view/single_chat_screen_view.dart';
import 'package:personal_injury_networking/ui/events/controller/events_controller.dart';
import 'package:provider/provider.dart';

import '../../../global/utils/app_text_styles.dart';
import '../../authentication/model/user_model.dart';

class AllUsersChat extends StatefulWidget {
  const AllUsersChat({super.key});

  @override
  State<AllUsersChat> createState() => _AllUsersChatState();
}

class _AllUsersChatState extends State<AllUsersChat> {
  List<ChatData> chatUsers = [];
  List<UserModel> allUsers = [];

  @override
  Widget build(BuildContext context) {
    chatUsers = [];
    allUsers = [];
    chatUsers = context.watch<UserChatData>().userChatsData;
    allUsers = context.watch<EventsController>().allUsers;
    return Scaffold(
        backgroundColor: const Color(0xFFf5f4ff),
        body: (allUsers.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : Column(
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
                  if (chatUsers.isNotEmpty) ...[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.sp),
                                topRight: Radius.circular(30.sp))),
                        child: ListView.builder(
                            // physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            // shrinkWrap: true,
                            itemCount: chatUsers.length,
                            itemBuilder: (context, index) {
                              UserModel user = allUsers.firstWhere((element) =>
                                  element.id == chatUsers[index].to);
                              DateTime dateTime = chatUsers[index].dateTime;
                              String fDateTime =
                                  DateFormat("HH:mm a").format(dateTime);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              SingleChatScreenView(user: user))
                                      // PageTransition(
                                      //   childCurrent: widget,
                                      //   type:
                                      //       PageTransitionType.rightToLeftJoined,
                                      //   alignment: Alignment.center,
                                      //   duration:
                                      //       const Duration(milliseconds: 200),
                                      //   reverseDuration:
                                      //       const Duration(milliseconds: 200),
                                      //   child: ChatScreen(
                                      //     user: user,
                                      //   ),
                                      // ),
                                      );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 15.w,
                                      right: 15.w,
                                      top: 14.h,
                                      bottom: 8.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                      user.userName,
                                                      style: AppTextStyles.josefin(
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: const Color(
                                                                  0xFF1A1167),
                                                              fontSize: 12.sp)),
                                                    ),
                                                    CustomSizeBox(6.h),
                                                    Text(
                                                      chatUsers[index]
                                                          .lastMessage,
                                                      style: AppTextStyles.josefin(
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
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
                                          fDateTime,
                                          style: AppTextStyles.josefin(
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xFF857FB4),
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
                  ] else ...[
                    Expanded(
                        child: Center(
                      child: Text(
                        "No chat found",
                        style: AppTextStyles.josefin(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w200)),
                      ),
                    ))
                  ]
                ],
              ));
  }
}
