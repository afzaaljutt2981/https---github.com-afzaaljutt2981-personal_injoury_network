import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/utils/constants.dart';
import 'package:personal_injury_networking/global/utils/functions.dart';
import 'package:provider/provider.dart';

import '../../../../../global/utils/app_colors.dart';
import '../../../../../global/utils/app_text_styles.dart';
import '../../../../../global/utils/drop_list_model.dart';
import '../../../../../global/utils/select_drop_list.dart';
import '../../../../authentication/model/user_model.dart';
import '../controller/allRegisteredUsersMarketers.dart';

class AllRegisteredMarketersScreen extends StatefulWidget {
  const AllRegisteredMarketersScreen({super.key});

  @override
  State<AllRegisteredMarketersScreen> createState() =>
      _AllRegisteredUsersScreenState();
}

class _AllRegisteredUsersScreenState
    extends State<AllRegisteredMarketersScreen> {
  List<UserModel> allUsers = [];
  bool isDropdownOpen = false;
  DropListModel dropListModel = DropListModel([
    OptionItem(id: "1", title: "User"),
    OptionItem(id: "2", title: "Marketer")
  ]);
  OptionItem optionItemSelected = OptionItem(id: null, title: "Category");

  @override
  Widget build(BuildContext context) {
    allUsers = context
        .watch<AllRegisteredMarketersController>()
        .allUsers
        .where((element) =>
            (optionItemSelected.id == "1"
                ? element.userType == Constants.userType
                : optionItemSelected.id == "2"
                    ? element.userType != Constants.userType
                    : element.userType == Constants.userType) &&
            (element.isDeleted ?? false) == false)
        .toList();
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
                "All Registered Marketers",
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        color: const Color(0xFF120D26),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),
        ),
        body: allUsers.isNotEmpty
            ? Column(
                children: [
                  SelectDropList(
                    this.optionItemSelected,
                    this.dropListModel,
                    (optionItem) {
                      optionItemSelected = optionItem;

                      // context
                      //     .watch<AllRegisteredUsersController>();
                      setState(() {
                        // Provider.of<AllRegisteredUsersController>(context, listen: true).getAllUsers();
                        //
                        // Provider.of<AllRegisteredUsersController>(context, listen: false).refreshState();
                      });
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: allUsers.length,
                        itemBuilder: (context, index) {
                          var model = allUsers[index];
                          return Padding(
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
                                  Image(
                                      width: 50.sp,
                                      height: 50.sp,
                                      image: const AssetImage(
                                          'assets/images/profile_pic.png')),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${model.firstName} ${model.lastName}",
                                              style: AppTextStyles.josefin(
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      color: const Color(
                                                          0xFF1A1167),
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            Text(
                                              model.position ?? "",
                                              style: AppTextStyles.josefin(
                                                  style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: const Color(
                                                          0xFF847FB3),
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            print("Delete should be initiated");
                                            if (model.id?.isNotEmpty ?? false) {
                                              context
                                                  .read<
                                                      AllRegisteredMarketersController>()
                                                  .updateUser(context,
                                                      userUidToUpdate:
                                                          model.id!,
                                                      isDeleted: true);
                                            } else {
                                              Functions.showSnackBar(context,
                                                  "Invalid user, unable to delete this user");
                                            }
                                          },
                                          child: Image(
                                            height: 20.sp,
                                            width: 20.sp,
                                            image: const AssetImage(
                                                'assets/images/delete.png'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
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
              )
        // Column(
        //   children: [
        //     CustomSizeBox(5.h),
        //     Expanded(
        //         child: ListView.builder(
        //             physics: const BouncingScrollPhysics(),
        //             itemCount: 10,
        //             shrinkWrap: true,
        //             itemBuilder: (context, index) {
        //               return
        //                 Padding(
        //                 padding: EdgeInsets.only(
        //                     left: 15.w, right: 15.w, bottom: 10.h),
        //                 child: Container(
        //                   decoration: BoxDecoration(
        //                     color: Colors.white,
        //                     borderRadius: BorderRadius.circular(15.sp),
        //                   ),
        //                   child: Padding(
        //                     padding: EdgeInsets.symmetric(
        //                         horizontal: 10.w, vertical: 10.h),
        //                     child: Row(children: [
        //                       Image(
        //                           width: 50.sp,
        //                           height: 50.sp,
        //                           image: const AssetImage(
        //                               'assets/images/profile_pic.png')),
        //                       SizedBox(
        //                         width: 10.w,
        //                       ),
        //                       Text(
        //                         'Amanda Leighton',
        //                         style: AppTextStyles.josefin(
        //                             style: TextStyle(
        //                                 fontSize: 14.sp,
        //                                 color: const Color(0xFF1A1167),
        //                                 fontWeight: FontWeight.w400)),
        //                       )
        //                     ]),
        //                   ),
        //                 ),
        //               );
        //             })),
        //   ],
        // ),
        );
  }
}
