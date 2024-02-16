import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/ui/authentication/model/job_position_model.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/chat_screen/view/view_users.dart';
import 'package:personal_injury_networking/ui/find_users/controller/find_users_controller.dart';
import 'package:provider/provider.dart';

import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';

class FindUser extends StatefulWidget {
  const FindUser({super.key});

  @override
  State<FindUser> createState() => _FindUser();
}

class _FindUser extends State<FindUser> {
  TextEditingController descriptionController = TextEditingController();
  Uint8List? image1;
  List<String> selectedCounty = [];
  List<String> selectedJobPosition = [];
  bool expandController = false;
  List<UserModel?>? allUsers = [];

  @override
  Widget build(BuildContext context) {
    allUsers = context.watch<FindUserController>().allUsers;
    print("JobPositionModel.counties - >  ${JobPositionModel.counties}");
    print("allUsers - >  ${allUsers}");
    return Scaffold(
        backgroundColor: AppColors.kWhiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.kWhiteColor,
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
                  color: AppColors.kBlackColor,
                  size: 18.sp,
                ),
              ),
            ),
          ),
          title: Center(
            child: Padding(
              padding: EdgeInsets.only(right: 45.w),
              child: Text(
                "Find Users",
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSizeBox(20.h),
                        Text(
                          'County',
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: Colors.black, fontSize: 14.sp)),
                        ),
                        CustomSizeBox(7.h),
                        // textfield(titleController, 'Add title', false, 1,
                        //     AppColors.textFieldColor),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Row(
                              children: [
                                // Icon(
                                //   Icons.list,
                                //   size: 16,
                                //   color: Colors.yellow,
                                // ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                    child: Text(
                                  'Select here',
                                  style: AppTextStyles.josefin(
                                    style: TextStyle(
                                      color: const Color(0xFF1F314A)
                                          .withOpacity(
                                              selectedCounty == "" ? 0.31 : 1),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ],
                            ),
                            items: JobPositionModel.counties
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item ?? "",
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item ?? "",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(width: 10),
                                          // Provides a space between the text and the icon
                                          item == "Select All"
                                              ? const Icon(
                                                  Icons.select_all_outlined,
                                                  // Replace with your desired icon
                                                  size: 24,
                                                )
                                              : selectedCounty.contains(
                                                          item.toString()) ||
                                                      selectedCounty
                                                          .contains("all")
                                                  ? const Icon(
                                                      Icons.done,
                                                      // Replace with your desired icon
                                                      size: 24,
                                                    )
                                                  : const SizedBox(),
                                        ],
                                      ),
                                    ))
                                .toList(),
                            // value: items[0],
                            onChanged: (String? value) {
                              if (value == "Select All") {
                                setState(() {
                                  selectedCounty = [];
                                  selectedCounty.add("all");
                                  context
                                      .read<FindUserController>()
                                      .setCounty(selectedCounty);
                                });
                                return;
                              }
                              ;
                              if (selectedCounty.contains("all")) {
                                selectedCounty = [];
                              }
                              setState(() {
                                selectedCounty.add(value ?? "");
                                context
                                    .read<FindUserController>()
                                    .setCounty(selectedCounty);
                              });
                            },
                            // dropdownSearchData: DropdownSearchData(
                            //     searchController: TextEditingController(
                            //         text: "United States")),
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: AppColors.textFieldColor,
                              ),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                              ),
                              iconSize: 30,
                              iconEnabledColor: AppColors.kPrimaryColor,
                              iconDisabledColor: Colors.grey,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              // offset: const Offset(-40, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all<double>(6),
                                thumbVisibility:
                                    MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),

                        CustomSizeBox(20.h),
                        Text(
                          'Select Position/Job',
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: Colors.black, fontSize: 14.sp)),
                        ),
                        CustomSizeBox(7.h),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Row(
                              children: [
                                // Icon(
                                //   Icons.list,
                                //   size: 16,
                                //   color: Colors.yellow,
                                // ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Expanded(
                                    child: Text(
                                  'Select here',
                                  style: AppTextStyles.josefin(
                                    style: TextStyle(
                                      color: const Color(0xFF1F314A)
                                          .withOpacity(selectedJobPosition == ""
                                              ? 0.31
                                              : 1),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ],
                            ),
                            items: JobPositionModel.jobList
                                .map((String item) => DropdownMenuItem<String>(
                                      value: item ?? "",
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item ?? "",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(width: 10),
                                          // Provides a space between the text and the icon
                                          item == "- Select All"
                                              ? const Icon(
                                                  Icons.select_all_outlined,
                                                  // Replace with your desired icon
                                                  size: 24,
                                                )
                                              : selectedJobPosition.contains(
                                                          (item ?? "")
                                                              .split("- ")?[1]
                                                              .toString()) ||
                                                      selectedJobPosition
                                                          .contains("all")
                                                  ? const Icon(
                                                      Icons.done,
                                                      // Replace with your desired icon
                                                      size: 24,
                                                    )
                                                  : const SizedBox(),
                                        ],
                                      ),
                                    ))
                                .toList(),
                            // value: items[0],
                            onChanged: (String? value) {
                              if (value == "- Select All") {
                                setState(() {
                                  selectedJobPosition = [];
                                  selectedJobPosition.add("all");
                                  context
                                      .read<FindUserController>()
                                      .setJob(selectedJobPosition);
                                });
                                return;
                              }
                              if (selectedJobPosition.contains("all")) {
                                selectedJobPosition = [];
                              }
                              setState(() {
                                selectedJobPosition
                                    .add((value ?? "").split("- ")?[1] ?? "");
                                context
                                    .read<FindUserController>()
                                    .setJob(selectedJobPosition);
                              });
                            },
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              padding:
                                  const EdgeInsets.only(left: 14, right: 14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: AppColors.textFieldColor,
                              ),
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                              ),
                              iconSize: 30,
                              iconEnabledColor: AppColors.kPrimaryColor,
                              iconDisabledColor: Colors.grey,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: Colors.white,
                              ),
                              // offset: const Offset(-40, 0),
                              scrollbarTheme: ScrollbarThemeData(
                                radius: const Radius.circular(40),
                                thickness: MaterialStateProperty.all<double>(6),
                                thumbVisibility:
                                    MaterialStateProperty.all<bool>(true),
                              ),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                              padding: EdgeInsets.only(left: 14, right: 14),
                            ),
                          ),
                        ),

                        CustomSizeBox(15.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_right_outlined,
                                      // Replace with your desired icon
                                      size: 24,
                                    ),
                                    Text(
                                      'Selected users',
                                      style: AppTextStyles.josefin(
                                          style: TextStyle(
                                              color: AppColors.kBlackColor,
                                              fontSize: 14.sp)),
                                    ),
                                    SizedBox(
                                      width: 20.sp,
                                    ),
                                    Text(
                                      '${allUsers?.length ?? 0}',
                                      style: AppTextStyles.josefin(
                                          style: TextStyle(
                                              color: AppColors
                                                  .kSnackbarSuccessColor,
                                              fontSize: 18.sp)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(context);
                              },
                              child: Row(
                                children: [
                                  Text(
                                    'view',
                                    style: AppTextStyles.josefin(
                                        style: TextStyle(
                                            color: AppColors.kBlackColor,
                                            fontSize: 18.sp)),
                                  ),
                                  SizedBox(
                                    width: 10.sp,
                                  ),
                                  const Icon(
                                    Icons.remove_red_eye,
                                    // Replace with your desired icon
                                    size: 24,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ));
  }

  Widget textfield(TextEditingController controller, String hintText,
      bool readonly, int maxlines, Color color,
      {void Function()? onTap,
      Widget? suffix,
      TextAlignVertical? textAlignVertical}) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(10.sp)),
      child: TextFormField(
        textAlignVertical: textAlignVertical,
        onTap: onTap,
        readOnly: readonly,
        maxLines: maxlines,
        controller: controller,
        style: AppTextStyles.josefin(
            style: TextStyle(color: const Color(0xFF1F314A), fontSize: 18.sp)),
        decoration: InputDecoration(
            suffixIcon: suffix,
            contentPadding: EdgeInsets.only(left: 10.w),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: AppTextStyles.josefin(
                style: TextStyle(
                    color: const Color(0xFF1F314A).withOpacity(0.40),
                    fontSize: 15.sp))),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    print("allUsers -> $allUsers");
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.sp),
          topRight: Radius.circular(30.sp),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return ViewUsers(
            allUsers: allUsers ?? [],
          );
        });
      },
    );
  }
}
