import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/app_buttons/app_primary_button.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';

class MyProfileInfo extends StatefulWidget {
  const MyProfileInfo({super.key});

  @override
  State<MyProfileInfo> createState() => _MyProfileInfoState();
}

class _MyProfileInfoState extends State<MyProfileInfo> {
  @override
  @override
  void initState() {
    super.initState();
    textFieldController[0].text = 'Fiverr LLC';
    textFieldController[1].text = 'Manager';
    textFieldController[2].text = 'www.xyz@gmail.com';
    textFieldController[3].text = '+1 234 453 4563';
    textFieldController[4].text = '54 Houston, Texas, 76778, US ';
    textFieldController[5].text =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s";
  }

  bool readOnlyTextFields = false;
  bool imageEditAble = false;
  final textFieldController =
      List.generate(6, (i) => TextEditingController(), growable: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFf5f4ff),
        body: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFFf5f4ff),
            child: Padding(
              padding: EdgeInsets.only(top: 50.h, bottom: 15.h),
              child: Center(
                child: Text(
                  'Profile',
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.kBlackColor)),
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.sp),
                    topRight: Radius.circular(35.sp))),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSizeBox(20.h),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            height: 100.sp,
                            width: 100.sp,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                          ),
                          GestureDetector(
                            onTap: () {
                              imageEditAble
                                  ? showBottomModelSheetWidget()
                                  : null;
                            },
                            child: Image(
                              height: 90.sp,
                              width: 90.sp,
                              image: const AssetImage(
                                  'assets/images/profile_pic.png'),
                            ),
                          ),
                          imageEditAble
                              ? Positioned(
                                  right: 4.h,
                                  top: 50.sp,
                                  child: Container(
                                    height: 25.sp,
                                    width: 25.sp,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],
                                      shape: BoxShape.circle,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        imageEditAble
                                            ? showBottomModelSheetWidget()
                                            : null;
                                      },
                                      child: Center(
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: 17.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                    CustomSizeBox(10.h),
                    Center(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'John Smith',
                                style: AppTextStyles.josefin(
                                    style: TextStyle(
                                        color: const Color(0xFF27261E),
                                        fontSize: 24.sp)),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    imageEditAble = !imageEditAble;
                                  });
                                },
                                child: Image(
                                    width: 15.sp,
                                    height: 15.sp,
                                    image: const AssetImage(
                                        'assets/images/edit_my_profile.png')),
                              )
                            ],
                          ),
                          CustomSizeBox(4.h),
                          Text(
                            'jonathansmith@gmail.com',
                            style: AppTextStyles.josefin(
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF27261E),
                                    fontSize: 14.sp)),
                          ),
                        ],
                      ),
                    ),
                    CustomSizeBox(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Text(
                            'Company',
                            style: AppTextStyles.josefin(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1A1167),
                                    fontSize: 12.sp)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20.w),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                readOnlyTextFields = !readOnlyTextFields;
                              });
                            },
                            child: Image(
                                width: 16.sp,
                                height: 16.sp,
                                image: const AssetImage(
                                    'assets/images/edit_my_profile.png')),
                          ),
                        ),
                      ],
                    ),
                    textField('Enter Your Company', 0, textFieldController[0]),
                    CustomSizeBox(5.h),
                    Text(
                      'Job/Position',
                      style: AppTextStyles.josefin(
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A1167),
                              fontSize: 12.sp)),
                    ),
                    textField('Enter Your Job', 1, textFieldController[1]),
                    CustomSizeBox(5.h),
                    Text(
                      'Website',
                      style: AppTextStyles.josefin(
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A1167),
                              fontSize: 12.sp)),
                    ),
                    textField('Enter Your Website', 2, textFieldController[2]),
                    CustomSizeBox(5.h),
                    Text(
                      'Cellphone',
                      style: AppTextStyles.josefin(
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A1167),
                              fontSize: 12.sp)),
                    ),
                    textField(
                        'Enter Your Phone No.', 3, textFieldController[3]),
                    CustomSizeBox(5.h),
                    Text(
                      'Location',
                      style: AppTextStyles.josefin(
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A1167),
                              fontSize: 12.sp)),
                    ),
                    textField('Your Location', 4, textFieldController[4]),
                    CustomSizeBox(5.h),
                    Text(
                      'Hobby/ Interests',
                      style: AppTextStyles.josefin(
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1A1167),
                              fontSize: 12.sp)),
                    ),
                    textField('Your Hobbies', 5, textFieldController[5]),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 25.w, right: 25.w, bottom: 20.w),
                      child: GetButton(50.h, () {
                        setState(() {
                          readOnlyTextFields = !readOnlyTextFields;
                          imageEditAble = !imageEditAble;
                        });
                      },
                          Text(
                            'Save',
                            style: AppTextStyles.josefin(
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                          )),
                    )
                  ],
                ),
              ),
            ),
          ))
        ]));
  }

  showBottomModelSheetWidget() {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomSizeBox(5.h),
            Center(
                child: Container(
              height: 3.h,
              width: 20.w,
              decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(10.sp)),
            )),
            CustomSizeBox(10.h),
            Center(
              child: Text(
                "Select source",
                style: AppTextStyles.josefin(
                    style: const TextStyle(
                        color: AppColors.kBlackColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700)),
              ),
            ),
            Divider(
              thickness: 0.7,
              color: AppColors.kBlackColor.withOpacity(0.1),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                selectPicCatagory(
                    "Camera", Icons.camera_alt_outlined, Colors.white,
                    onTap: () {
                  // print("object");
                  //  pickImageFromCamera()

                  // .then((value) => Navigator.of(context).pop());
                }),
                selectPicCatagory("Files", Icons.folder, Colors.blue,
                    onTap: () {
                  // pickImageFromGallery()
                  //     .then((value) => Navigator.of(context).pop());
                }),
                selectPicCatagory("Gallery", Icons.image_outlined, Colors.white,
                    onTap: () {
                  // pickImageFromGallery()
                  //     .then((value) => Navigator.of(context).pop());
                }),
              ],
            ),
            const SizedBox(
              height: 100,
            )
          ],
        );
      },
    );
  }

  Widget selectPicCatagory(String text, IconData icon, Color iconColor,
      {required Function onTap}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.kSecondryColor,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        color: AppColors.kBlackColor.withOpacity(0.12),
                        spreadRadius: 3)
                  ]),
              height: 45,
              width: 45,
              child: Center(
                  child: IconButton(
                onPressed: () {
                  onTap();
                },
                icon: Icon(icon),
                color: iconColor,
                iconSize: 28,
              ))),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              text,
              style: AppTextStyles.josefin(
                  style: const TextStyle(
                color: AppColors.kBlackColor,
                fontSize: 16,
              )),
            ),
          )
        ],
      ),
    );
  }

  Widget textField(
      String hintText, int index, TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.sp), color: Colors.white),
      child: TextFormField(
        maxLines: index == 5 ? 4 : 1,
        readOnly: readOnlyTextFields == true ? false : true,
        textInputAction:
            index == 5 ? TextInputAction.done : TextInputAction.next,
        controller: controller,
        style: AppTextStyles.josefin(
          style: TextStyle(
              color: readOnlyTextFields
                  ? Colors.deepPurple
                  : const Color(0xFF857FB4),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400),
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 10.h),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: AppTextStyles.josefin(
            style: TextStyle(
              color: const Color(0xFF1F314A).withOpacity(0.31),
              fontSize: 11.sp,
            ),
          ),
        ),
      ),
    );
  }
}
