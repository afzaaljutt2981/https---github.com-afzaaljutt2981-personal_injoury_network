import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:personal_injury_networking/global/app_buttons/app_primary_button.dart';
import 'package:personal_injury_networking/global/app_buttons/white_background_button.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/ui/create_event/controller/create_event_controller.dart';
import 'package:personal_injury_networking/ui/home/view/navigation_view.dart';
import 'package:provider/provider.dart';

import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../../global/utils/functions.dart';
import '../models/address_model.dart';
import 'event_location.dart';

class AddEventView extends StatefulWidget {
  const AddEventView({super.key});

  @override
  State<AddEventView> createState() => _AddEventViewState();
}

bool index1 = false;
bool index2 = false;
bool index3 = false;

class _AddEventViewState extends State<AddEventView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  DateTime? selectedDate;
  double latitude = 0.0;
  double longitude = 0.0;
  DateTime initialDate = DateTime.now();
  DateTime? parseTime;
  DateTime? endParseTime;
  Uint8List? image1;

  @override
  Widget build(BuildContext context) {
    String formattedDate = '';
    if (selectedDate != null) {
      formattedDate = DateFormat('dd MMM, yyyy').format(selectedDate!);
    }
    return Scaffold(
        backgroundColor: AppColors.kPrimaryColor,
        appBar: AppBar(
          backgroundColor: AppColors.kPrimaryColor,
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
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     GestureDetector(
                              //       onTap: () {
                              //         setState(() {
                              //           index1 = true;
                              //           index2 = false;
                              //           index3 = false;
                              //         });
                              //       },
                              //       child: Container(
                              //         decoration: BoxDecoration(
                              //             color: index1 == false
                              //                 ? Colors.white
                              //                 : const Color(0xFF5669FF),
                              //             borderRadius:
                              //                 BorderRadius.circular(15.sp)),
                              //         child: Padding(
                              //           padding: EdgeInsets.symmetric(
                              //               vertical: 10.sp, horizontal: 12.sp),
                              //           child: Text(
                              //             'Today',
                              //             style: AppTextStyles.josefin(
                              //                 style: TextStyle(
                              //                     color: index1 == false
                              //                         ? AppColors.kBlackColor
                              //                         : Colors.white,
                              //                     fontSize: 12.sp)),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     GestureDetector(
                              //       onTap: () {
                              //         setState(() {
                              //           index1 = false;
                              //           index2 = true;
                              //           index3 = false;
                              //         });
                              //       },
                              //       child: Container(
                              //         decoration: BoxDecoration(
                              //             color: index2 == false
                              //                 ? Colors.white
                              //                 : const Color(0xFF5669FF),
                              //             borderRadius:
                              //                 BorderRadius.circular(15.sp)),
                              //         child: Padding(
                              //           padding: EdgeInsets.symmetric(
                              //               vertical: 10.sp, horizontal: 12.sp),
                              //           child: Text(
                              //             'Tomorrow',
                              //             style: AppTextStyles.josefin(
                              //                 style: TextStyle(
                              //                     color: index2 == false
                              //                         ? AppColors.kBlackColor
                              //                         : Colors.white,
                              //                     fontSize: 12.sp)),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     GestureDetector(
                              //       onTap: () {
                              //         setState(() {
                              //           index1 = false;
                              //           index2 = false;
                              //           index3 = true;
                              //         });
                              //       },
                              //       child: Container(
                              //         decoration: BoxDecoration(
                              //             color: index3 == false
                              //                 ? Colors.white
                              //                 : const Color(0xFF5669FF),
                              //             borderRadius:
                              //                 BorderRadius.circular(15.sp)),
                              //         child: Padding(
                              //           padding: EdgeInsets.symmetric(
                              //               vertical: 10.sp, horizontal: 12.sp),
                              //           child: Text(
                              //             'This week',
                              //             style: AppTextStyles.josefin(
                              //                 style: TextStyle(
                              //                     color: index3 == false
                              //                         ? AppColors.kBlackColor
                              //                         : Colors.white,
                              //                     fontSize: 12.sp)),
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              InkWell(
                                onTap: () async {
                                  DateTime? dt = await _selectDate(context);
                                  if (dt != null) {
                                    setState(() {
                                      selectedDate = dt;
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10.h),
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
                                        // crossAxisAlignment:
                                        //     CrossAxisAlignment.center,
                                        children: [
                                          Image(
                                            height: 18.sp,
                                            width: 18.sp,
                                            image: const AssetImage(
                                                'assets/images/calendar_create_event.png'),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w),
                                              child: Text(
                                                (formattedDate != "")
                                                    ? formattedDate
                                                    : "Choose from calender",
                                                style: AppTextStyles.josefin(
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .kBlackColor,
                                                        fontSize: 12.sp)),
                                              ),
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
                                ),
                              )
                            ],
                          ),
                        ),
                        timeSlot(),
                        CustomSizeBox(20.h),
                        Text(
                          'Title',
                          style: AppTextStyles.josefin(
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.sp)),
                        ),
                        CustomSizeBox(7.h),
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
                        locationField(),
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
                                'Write event description here..',
                                false,
                                5,
                                Colors.grey[400]!),
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
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.sp)),
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
                                              'assets/images/add_banner_create_event.png'),
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
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: GetwhiteButton(50.sp, () async {
                      if (formattedDate == '') {
                        Functions.showSnackBar(
                            context, "please select date of event");
                        return;
                      } else if (startTime.text.isEmpty) {
                        Functions.showSnackBar(
                            context, "please select start time of event");
                        return;
                      } else if (endTime.text.isEmpty) {
                        Functions.showSnackBar(
                            context, "please select end time of event");
                        return;
                      } else if (titleController.text.isEmpty) {
                        Functions.showSnackBar(
                            context, "please add title of event");
                        return;
                      } else if (locationController.text.isEmpty) {
                        Functions.showSnackBar(
                            context, "please add location of event");
                        return;
                      } else if (descriptionController.text.isEmpty) {
                        Functions.showSnackBar(
                            context, "please add description of event");
                        return;
                      } else if (image1 == null) {
                        Functions.showSnackBar(
                            context, "please add image of event");
                        return;
                      }
                      Functions.showLoaderDialog(context);
                      String url = await Functions.uploadPic(image1!, "events");
                      // ignore: use_build_context_synchronously
                      await context.read<CreateEventController>().addEvent(
                          endTime: endParseTime!,
                          startTime: parseTime!,
                          address: locationController.text,
                          pImage: url,
                          description: descriptionController.text,
                          title: titleController.text,
                          dateTime: selectedDate!,
                          latitude: latitude,
                          longitude: longitude);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
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

  Widget locationField() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.sp)),
      child: TextFormField(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (ctx) =>
                      SelectLocation(primary: AppColors.kPrimaryColor)))
              .then((value) {
            if (value is AddressModel) {
              locationController.text = value.address??"";
              setState(() {
                latitude = value.latitude??0;
                longitude = value.longitude??0;
              });
            }
          });
        },
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
                    titleController.text,
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
                  () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                BottomNavigationScreen(selectedIndex: 0)),
                        (route) => false);
                  },
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

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(3000));
    return picked;
  }

  Widget timeSlot() {
    return Row(
      children: [
        Expanded(
            child: textfield(startTime, "From", true, 1, Colors.white,
                suffix: const Icon(Icons.timer),
                textAlignVertical: TextAlignVertical.center, onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );
          if (pickedTime != null) {
            DateTime now = DateTime.now();
            parseTime = DateTime(now.year, now.month, now.day, pickedTime.hour,
                pickedTime.minute);
            String formattedTime = DateFormat('hh:mm').format(parseTime!);
            setState(() {
              startTime.text = formattedTime; //set the value of text field.
            });
          } else {}
        })),
        const SizedBox(
          width: 10,
        ),
        Expanded(
            child: textfield(endTime, "To", true, 1, Colors.white,
                suffix: const Icon(Icons.timer),
                textAlignVertical: TextAlignVertical.center, onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );
          if (pickedTime != null) {
            DateTime now = DateTime.now();
            endParseTime = DateTime(now.year, now.month, now.day,
                pickedTime.hour, pickedTime.minute);
            String formattedTime = DateFormat('hh:mm').format(endParseTime!);
            setState(() {
              endTime.text = formattedTime; //set the value of text field.
            });
          } else {}
        })),
      ],
    );
  }
}
