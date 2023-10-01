import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/app_buttons/white_background_button.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';

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
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
          title: Center(
            child: Text(
              "Create Event",
              style: AppTextStyles.josefin(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700)),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: GestureDetector(
                onTap: () {},
                child: Image(
                  height: 22.sp,
                  width: 22.sp,
                  image: const AssetImage(
                      'assets/images/more_circle_create_event.png'),
                ),
              ),
            ),
          ],
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
                        textfield(
                            descriptionController,
                            'Write event discription here..',
                            false,
                            5,
                            Colors.grey[400]!),
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
              padding: EdgeInsets.only(left: 20.w, right: 30.w, bottom: 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 230.w,
                    child: GetwhiteButton(50.sp, () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const EventsQrView()));
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
            style: TextStyle(color: const Color(0xFF1F314A), fontSize: 15.sp)),
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
}
