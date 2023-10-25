import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/app_buttons/app_primary_button.dart';
import 'package:personal_injury_networking/global/app_buttons/white_background_button.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/helper/text_field_widget.dart';

import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';

class AddEventView extends StatefulWidget {
  const AddEventView({super.key});

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

bool index1 = false;
bool index2 = false;
bool index3 = false;
TextEditingController titleController = TextEditingController();
TextEditingController locationController = TextEditingController();
TextEditingController descriptionController = TextEditingController();

class _AddEventViewState extends State<AddEventView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.kPrimaryColor,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(17.sp),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          title: Center(
            child: Padding(
              padding: EdgeInsets.only(right: 45.w),
              child: Text(
                "Create Event",
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        color: Colors.white,
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
                        Center(
                          child: Text(
                            'Select Time & Date',
                            style: AppTextStyles.josefin(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.sp)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 35.sp, vertical: 12.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        index1 = true;
                                        index2 = false;
                                        index3 = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: index1 == false
                                              ? Colors.white
                                              : const Color(0xFF5669FF),
                                          borderRadius:
                                              BorderRadius.circular(15.sp)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.sp, horizontal: 12.sp),
                                        child: Text(
                                          'Today',
                                          style: AppTextStyles.josefin(
                                              style: TextStyle(
                                                  color: index1 == false
                                                      ? AppColors.kBlackColor
                                                      : Colors.white,
                                                  fontSize: 12.sp)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        index1 = false;
                                        index2 = true;
                                        index3 = false;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: index2 == false
                                              ? Colors.white
                                              : const Color(0xFF5669FF),
                                          borderRadius:
                                              BorderRadius.circular(15.sp)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.sp, horizontal: 12.sp),
                                        child: Text(
                                          'Tomorrow',
                                          style: AppTextStyles.josefin(
                                              style: TextStyle(
                                                  color: index2 == false
                                                      ? AppColors.kBlackColor
                                                      : Colors.white,
                                                  fontSize: 12.sp)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        index1 = false;
                                        index2 = false;
                                        index3 = true;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: index3 == false
                                              ? Colors.white
                                              : const Color(0xFF5669FF),
                                          borderRadius:
                                              BorderRadius.circular(15.sp)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.sp, horizontal: 12.sp),
                                        child: Text(
                                          'This week',
                                          style: AppTextStyles.josefin(
                                              style: TextStyle(
                                                  color: index3 == false
                                                      ? AppColors.kBlackColor
                                                      : Colors.white,
                                                  fontSize: 12.sp)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: 50.w, top: 10.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(15.sp)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 7.sp, horizontal: 12.sp),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image(
                                          height: 18.sp,
                                          width: 18.sp,
                                          image: const AssetImage(
                                              'assets/images/calendar_create_event.png'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: Text(
                                            "Choose from calander",
                                            style: AppTextStyles.josefin(
                                                style: TextStyle(
                                                    color:
                                                        AppColors.kBlackColor,
                                                    fontSize: 12.sp)),
                                          ),
                                        ),
                                        Icon(
                                          Icons.navigate_next,
                                          color: AppColors.kPrimaryColor,
                                          size: 22.sp,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        CustomSizeBox(20.h),
                        textfield(titleController, 'Add title', false, 1,
                            Colors.white),
                        CustomSizeBox(20.h),
                        TextFieldWidget(
                            controller: locationController, index: 1,
                            hintText: "select location", obsecureTerxt: false,
                            identityText: "Location", readOnly: true),
                        Text(
                          'Location',
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp)),
                        ),
                        CustomSizeBox(7.h),
                        locationfield(),
                        CustomSizeBox(20.h),
                        Text(
                          'Event Description',
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp)),
                        ),
                        CustomSizeBox(7.h),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[400]!,
                              borderRadius: BorderRadius.circular(10.sp)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 4.h, bottom: 4.h),
                            child: textfield(
                                descriptionController,
                                'Write event discription here..',
                                false,
                                5,
                                Colors.grey[400]!),
                          ),
                        ),
                        CustomSizeBox(15.h),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.sp)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Column(
                              children: [
                                Image(
                                  height: 30.sp,
                                  width: 30.sp,
                                  image: const AssetImage(
                                      'assets/images/add_banner_create_event.png'),
                                ),
                                CustomSizeBox(10.h),
                                Text(
                                  '+Add banner',
                                  style: AppTextStyles.josefin(
                                      style: TextStyle(
                                          color: const Color(0xFF7E8CA0),
                                          fontSize: 12.sp)),
                                ),
                              ],
                            ),
                          ),
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
                  SizedBox(
                    width: 230.w,
                    child: GetwhiteButton(50.sp, () {
                      eventCreated();
                    },
                        Text(
                          "Save",
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: AppColors.kPrimaryColor,
                                  fontSize: 17.sp)),
                        )),
                  ),
                  Image(
                    height: 45.sp,
                    width: 45.sp,
                    image: const AssetImage(
                        'assets/images/frame_create_event.png'),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget textfield(TextEditingController controller, String hintText,
      bool readonly, int maxlines, Color color) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(10.sp)),
      child: TextFormField(
        readOnly: readonly,
        maxLines: maxlines,
        controller: controller,
        style: AppTextStyles.josefin(
            style: TextStyle(color: const Color(0xFF1F314A), fontSize: 18.sp)),
        decoration: InputDecoration(
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

  Widget locationfield() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.sp)),
      child: TextFormField(
        readOnly: true,
        maxLines: 1,
        controller: locationController,
        style: AppTextStyles.josefin(
            style: TextStyle(color: const Color(0xFF1F314A), fontSize: 15.sp)),
        decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.navigate_next,
              color: AppColors.kPrimaryColor,
              size: 22.sp,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                  left: 7.sp, right: 5.sp, top: 5.sp, bottom: 5.sp),
              child: Image(
                height: 10.sp,
                width: 10.sp,
                image: const AssetImage(
                    'assets/images/location_map_create_event.png'),
              ),
            ),
            contentPadding: EdgeInsets.only(left: 10.w, top: 13.h),
            border: InputBorder.none,
            hintText: 'New york, USA',
            hintStyle: AppTextStyles.josefin(
                style: TextStyle(
                    color: const Color(0xFF1F314A).withOpacity(0.40),
                    fontSize: 15.sp))),
      ),
    );
  }

  void eventCreated() {
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
                  CustomSizeBox(33.h),
                  Image(
                      height: 130.sp,
                      width: 130.sp,
                      image: const AssetImage(
                          'assets/images/no_history_orgnaizer_event.png')),
                  CustomSizeBox(28.h),
                  Text(
                    'Event Name',
                    style: AppTextStyles.josefin(
                        style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.kBlackColor)),
                  ),
                  CustomSizeBox(18.h),
                  Text(
                    'Event Created  Successfully!',
                    style: AppTextStyles.josefin(
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.kBlackColor)),
                  ),
                ],
              )),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 25.h),
                child: GetButton(
                  50.sp,
                  () {},
                  Text(
                    'View Your Events',
                    style: AppTextStyles.josefin(
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
