import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/utils/custom_snackbar.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/create_event/models/event_model.dart';
import 'package:personal_injury_networking/ui/events/controller/events_controller.dart';
import 'package:provider/provider.dart';

import '../../../global/app_buttons/app_primary_button.dart';
import '../../../global/helper/custom_sized_box.dart';
import '../../../global/utils/app_text_styles.dart';

class InviteGuests extends StatefulWidget {
  InviteGuests({super.key, required this.currentUser, required this.allUsers,required this.event});
  UserModel currentUser;
  List<UserModel> allUsers;
  EventModel event;
  @override
  State<InviteGuests> createState() => _InviteGuestsState();
}

class _InviteGuestsState extends State<InviteGuests> {
  bool isInvited = false;
  List<UserModel> tempList = [];
  List<UserModel> friends = [];
  List<UserModel> sFriends = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<String> friendsIds = widget.currentUser.followers;
    for (var element in widget.currentUser.followings) {
      if (friendsIds.contains(element)) {
      } else {
        friendsIds.add(element);
      }
    }
    for (var element1 in friendsIds) {
      friends
          .add(widget.allUsers.firstWhere((element) => element.id == element1));
    }
    sFriends = friends;
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
          child: Padding(
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
                Text(
                  'Invite Friend',
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          color: const Color(0xFF120D26),
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w500)),
                ),
                CustomSizeBox(10.h),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFF0F0F0)),
                    borderRadius: BorderRadius.circular(25.sp),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (v){
                            setState(() {
                              sFriends = searchUserByName(friends, v);
                            });
                          },
                          maxLines: 1,
                          readOnly: false,
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: const Color(0xFF1F314A),
                                  fontSize: 16.sp)),
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 12.w),
                              border: InputBorder.none,
                              hintText: "Search",
                              hintStyle: AppTextStyles.josefin(
                                  style: TextStyle(
                                      color: const Color(0xFF1F314A)
                                          .withOpacity(0.40),
                                      fontSize: 13.sp))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20.w, left: 5.w),
                        child: Image(
                          height: 18.sp,
                          width: 18.sp,
                          image:
                              const AssetImage('assets/images/search_icon.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                    ),
                    if(sFriends.isEmpty)...[
                      const Padding(
                        padding: EdgeInsets.only(top: 18.0),
                        child: Center(child: Text("No User Found")),
                      )
                    ]else...[
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: sFriends.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return friend(sFriends[index]);
                            }))],
                    if(sFriends.isNotEmpty)...[
                    Positioned(
                      bottom: 0.h,
                      right: 10.w,
                      left: 10.w,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GetButton(
                            50.sp,
                            () {
                              if(tempList.isNotEmpty){
                              for (var element in tempList) {
                                context.read<EventsController>().sendInvite(element.id, widget.event, context);
                              }
                            }else{
                                Navigator.pop(context);
                                CustomSnackBar(true).showInSnackBar("please select user to invite", context);
                              }},
                            Text(
                              'Invite',
                              style: AppTextStyles.josefin(
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            )),
                      ),
                    ),],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget friend(UserModel friend) {
    if(tempList.contains(friend) || widget.event.invites.contains(friend.id)){
      isInvited = true;
    }
    return GestureDetector(
      onTap: (){
        print("object");
        if(tempList.isNotEmpty){
          tempList.add(friend);
        }
      },
      onLongPress: (){
        print("here is long press");
        if(tempList.isEmpty){
          setState(() {
            tempList.add(friend);
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (friend.pImage != null) ...[
              CircleAvatar(
                backgroundImage: NetworkImage(friend.pImage!),
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
                  friend.firstName,
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          color: const Color(0xFF120D26),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500)),
                ),
                CustomSizeBox(5.h),
                Text(
                  '${friend.followers.length} Followers',
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          color: const Color(0xFF747688),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400)),
                ),
              ],
            )),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    // isInvited = !isInvited;
                  });
                },
                child: Image(
                  height: 18.sp,
                  width: 18.sp,
                  image: isInvited
                      ? const AssetImage('assets/images/select_invite_friend.png')
                      : const AssetImage(
                          'assets/images/no_select_invite_friend.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  List<UserModel> searchUserByName(List<UserModel> users, String searchTerm) {
    // Create an empty list to store the matching events.
    List<UserModel> matchingUsers = [];

    // Iterate through the eventList and check if the title contains the searchTerm.
    for (UserModel user in users) {
      if (user.firstName.toLowerCase().contains(searchTerm.toLowerCase())) {
        matchingUsers.add(user);
      }
    }

    // Return the list of matching events.
    return matchingUsers;
  }
}
