import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/ui/otherUserProfile/view/create_other_profile_view.dart';
import 'package:provider/provider.dart';

import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../authentication/model/user_model.dart';
import '../../events/controller/events_controller.dart';

class AllFriendsScreen extends StatefulWidget {
  AllFriendsScreen({super.key, required this.user});
  UserModel user;
  @override
  State<AllFriendsScreen> createState() => _AllFriendsScreenState();
}

class _AllFriendsScreenState extends State<AllFriendsScreen> {
  List<UserModel> friendsList = [];
  List<UserModel> allUsers = [];
  @override
  Widget build(BuildContext context) {
    allUsers = [];
    friendsList = [];
    allUsers = context.watch<EventsController>().allUsers;
    List<String> tempList = widget.user.followers + widget.user.followings;
    for (var element in allUsers) {
      if (tempList.contains(element.id)) {
        friendsList.add(element);
      }
    }
    return Scaffold(
      backgroundColor: const Color(0xFFf5f4ff),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(19.sp),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.kPrimaryColor,
              size: 18.sp,
            ),
          ),
        ),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 45.w),
            child: Text(
              "All Friends",
              style: AppTextStyles.josefin(
                  style: TextStyle(
                      color: const Color(0xFF120D26),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          CustomSizeBox(5.h),
          if (friendsList.isEmpty) ...[
            const Expanded(child: Center(child: Text("No Friend Yet")))
          ] else ...[
            Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: friendsList.length,
                    itemBuilder: (context, index) {
                      return friend(friendsList[index]);
                    })),
          ],
        ],
      ),
    );
  }

  Widget friend(UserModel user) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CreateOtherUserProfileView(
                    participant: user, currentUser: widget.user)));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.sp),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Row(children: [
              if (user.pImage != null) ...[
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(user.pImage!),
                )
              ] else ...[
                Image(
                    width: 50.sp,
                    height: 50.sp,
                    image: const AssetImage('assets/images/profile_pic.png'))
              ],
              SizedBox(
                width: 10.w,
              ),
              Text(
                user.userName,
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF1A1167),
                        fontWeight: FontWeight.w400)),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
