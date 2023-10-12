import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "Chats",
              style: AppTextStyles.josefin(
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF120D26))),
            ),
          ),
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(children: [
            ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 15,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          childCurrent: widget,
                          type: PageTransitionType.rightToLeftJoined,
                          alignment: Alignment.center,
                          duration: const Duration(milliseconds: 200),
                          reverseDuration: const Duration(milliseconds: 200),
                          child: const ChatScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 10),
                      child: Row(
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
                                          'Afzaal Jutt',
                                          style: AppTextStyles.josefin(
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.sp)),
                                        ),
                                        CustomSizeBox(6.h),
                                        Text(
                                          'How are you? I am doing well',
                                          style: AppTextStyles.josefin(
                                              style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 13.sp)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Just now',
                            style: AppTextStyles.josefin(
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12.sp)),
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ]),
        ));
  }
}
