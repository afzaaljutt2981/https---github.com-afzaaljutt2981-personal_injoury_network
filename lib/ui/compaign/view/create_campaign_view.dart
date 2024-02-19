import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/custom_snackbar.dart';
import 'package:personal_injury_networking/ui/authentication/model/job_position_model.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/chat_screen/view/view_users.dart';
import 'package:personal_injury_networking/ui/compaign/controller/compaign_controller.dart';
import 'package:provider/provider.dart';

import '../../../global/app_buttons/gradient_button.dart';
import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../../global/utils/functions.dart';

class CreateCampaign extends StatefulWidget {
  const CreateCampaign({super.key});

  @override
  State<CreateCampaign> createState() => _CreateCampaign();
}

class _CreateCampaign extends State<CreateCampaign> {
  TextEditingController descriptionController = TextEditingController();
  Uint8List? image1;
  List<String> selectedCounty = ["all"];
  List<String> selectedJobPosition = ["all"];
  bool expandController = false;
  List<UserModel?>? allUsers = [];

  @override
  Widget build(BuildContext context) {
    allUsers = context.watch<CampaignController>().allUsers;
    // print("JobPositionModel.counties - >  ${JobPositionModel.counties}");
    // print("allUsers - >  ${allUsers}");
    context.read<CampaignController>().setCounty(selectedCounty);
    context.read<CampaignController>().setJob(selectedJobPosition);
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
                "Create a Campaign",
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
                                      .read<CampaignController>()
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
                                    .read<CampaignController>()
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
                                      .read<CampaignController>()
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
                                    .read<CampaignController>()
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

                        CustomSizeBox(20.h),
                        Text(
                          'Message',
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: AppColors.kBlackColor,
                                  fontSize: 14.sp)),
                        ),
                        CustomSizeBox(7.h),
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.textFieldColor,
                              borderRadius: BorderRadius.circular(10.sp)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 14.h, bottom: 4.h),
                            child: textfield(
                                descriptionController,
                                'Type here..',
                                false,
                                5,
                                AppColors.textFieldColor),
                          ),
                        ),
                        CustomSizeBox(15.h),
                        InkWell(
                          onTap: () async {
                            final ImagePicker _picker = ImagePicker();
                            final XFile? pickedImage = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (pickedImage != null) {
                              image1 = await pickedImage.readAsBytes();
                              setState(() {});
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 110.h,
                            decoration: BoxDecoration(
                              color: AppColors.kWhiteColor,
                              borderRadius: BorderRadius.circular(10.sp),
                              border: const DashedBorder(
                                dashLength: 10,
                                left: BorderSide(
                                    color: AppColors.dashedBorderColor,
                                    width: 2.5),
                                top: BorderSide(
                                    color: AppColors.dashedBorderColor,
                                    width: 2.5),
                                right: BorderSide(
                                    color: AppColors.dashedBorderColor,
                                    width: 2.5),
                                bottom: BorderSide(
                                    color: AppColors.dashedBorderColor,
                                    width: 2.5),
                              ),
                            ),
                            child: (image1 != null)
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    child: Image(
                                      image: MemoryImage(image1!),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.h),
                                    child: Column(
                                      children: [
                                        Image(
                                          height: 30.sp,
                                          width: 30.sp,
                                          image: const AssetImage(
                                              'assets/images/select_banner_campaign.png'),
                                        ),
                                        CustomSizeBox(10.h),
                                        Text(
                                          '+Add banner',
                                          style: AppTextStyles.josefin(
                                              style: TextStyle(
                                                  color:
                                                      const Color(0xFF7E8CA0),
                                                  fontSize: 12.sp)),
                                        ),
                                      ],
                                    ),
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
            Padding(
              padding: EdgeInsets.only(
                  left: 20.w, right: 30.w, bottom: 30.h, top: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: ShapeDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(0.98, -0.22),
                        end: Alignment(-0.98, 0.22),
                        colors: [Color(0xFF212E73), Color(0xFF3047C0)],
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                      shadows: [
                        const BoxShadow(
                          color: Color(0x1A306D8A),
                          blurRadius: 30,
                          offset: Offset(0, 16),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: GetGradientButton(50.sp, () async {
                      if (selectedCounty.isEmpty) {
                        Functions.showSnackBar(
                            context, "please select country");
                        return;
                      } else if (selectedJobPosition.isEmpty) {
                        Functions.showSnackBar(
                            context, "please select job/position");
                        return;
                      } else if (descriptionController.text.isEmpty) {
                        Functions.showSnackBar(
                            context, "please add message of campaign");
                        return;
                      } else if (image1 == null) {
                        Functions.showSnackBar(
                            context, "please add image of campaign");
                        return;
                      }
                      print("Button clicked");
                      Functions.showLoaderDialog(context);
                      String url =
                          await Functions.uploadPic(image1!, "campaigns");
                      // // ignore: use_build_context_synchronously
                      await context.read<CampaignController>().createCampaign(
                          campaignCountry: selectedCounty,
                          campaignJob: selectedJobPosition,
                          campaignDescription: descriptionController.text,
                          pImage: url);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      Navigator.pop(context);
                      CustomSnackBar(true).showInSnackBar(
                          'Campaign created successfully For the people of $selectedCounty working as $selectedJobPosition."',
                          context);
                      // eventCreated(
                      //     "For the people of ${selectedCountry} working as ${selectedJobPosition}.");
                    },
                        Text(
                          "Submit",
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: AppColors.kWhiteColor,
                                  fontSize: 17.sp)),
                        )),
                  ),
                  // Image(
                  //   height: 45.sp,
                  //   width: 45.sp,
                  //   image: const AssetImage(
                  //       'assets/images/frame_create_event.png'),
                  // ),
                ],
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
            currentUser: null,
          );
        });
      },
    );
  }

  void eventCreated(String message) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.sp))),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.sp),
              topRight: Radius.circular(25.sp),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.55,
          child: Column(
            children: [
              Expanded(
                  child: Column(
                children: [
                  CustomSizeBox(10.h),
                  Image(
                      height: 130.sp,
                      width: 130.sp,
                      image: const AssetImage(
                          'assets/images/select_banner_campaign.png')),
                  CustomSizeBox(10.h),
                  Center(
                    child: Text(
                      message,
                      style: AppTextStyles.josefin(
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.kBlackColor)),
                    ),
                  ),
                  CustomSizeBox(8.h),
                  Text(
                    'Campaign Created  Successfully!',
                    style: AppTextStyles.josefin(
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.kBlackColor)),
                  ),
                ],
              )),
              // Padding(
              //   padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 25.h),
              //   child: GetButton(
              //     50.sp,
              //     () {
              //       Navigator.pushAndRemoveUntil(
              //           context,
              //           MaterialPageRoute(
              //               builder: (_) =>
              //                   BottomNavigationScreen(selectedIndex: 0)),
              //           (route) => false);
              //     },
              //     Text(
              //       'View Your Campaign',
              //       style: AppTextStyles.josefin(
              //           style: TextStyle(
              //               fontSize: 16.sp,
              //               fontWeight: FontWeight.w700,
              //               color: Colors.white)),
              //     ),
              //   ),
              // )
            ],
          ),
        );
      },
    );
  }
}
