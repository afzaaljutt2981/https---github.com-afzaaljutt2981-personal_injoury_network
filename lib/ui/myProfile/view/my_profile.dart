import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personal_injury_networking/global/app_buttons/app_primary_button.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/ui/authentication/controller/auth_controller.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/authentication/view/login_view.dart';
import 'package:personal_injury_networking/ui/myProfile/controller/my_profile_controller.dart';
import 'package:provider/provider.dart';
import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';
import '../../../global/utils/functions.dart';

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
    // user = context.watch<AuthController>().user;
    textFieldController[0].text = 'Fiverr LLC';
    textFieldController[1].text = 'Manager';
    textFieldController[2].text = 'www.xyz@gmail.com';
    textFieldController[3].text = '+1 234 453 4563';
    textFieldController[4].text = '54 Houston, Texas, 76778, US ';
    textFieldController[5].text =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s";
  }

  UserModel? user;
  Uint8List? image1;
  bool readOnlyTextFields = true;
  bool imageEditAble = false;
  final textFieldController =
      List.generate(7, (i) => TextEditingController(), growable: true);
  @override
  Widget build(BuildContext context) {
    user = context.watch<MyProfileController>().user;
    if(user != null){
    textFieldController[0].text = user!.company;
    textFieldController[1].text = user!.position;
    textFieldController[2].text = user!.website;
    textFieldController[3].text = user!.phone.toString();
    textFieldController[4].text = user!.location;
    textFieldController[5].text = user!.userName;
    }
    return Scaffold(
        backgroundColor: const Color(0xFFf5f4ff),
        body: (user != null)
            ? Column(children: [
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
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    imageEditAble
                                        ? showBottomModelSheetWidget()
                                        : null;
                                  },
                                  child: (image1 != null)
                                      ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: MemoryImage(image1!),):(user!.pImage != null)?CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(user!.pImage!,),
                                  ):const CircleAvatar(
                                    radius: 50,
                                    backgroundImage:AssetImage(
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
                                      user!.userName,
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
                                  user!.email,
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
                                  'User Name',
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
                          textField("user name", 5, textFieldController[5]),
                          Text(
                            'Company',
                            style: AppTextStyles.josefin(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1A1167),
                                    fontSize: 12.sp)),
                          ),
                          textField("company", 0, textFieldController[0]),
                          Text(
                            'Job/Position',
                            style: AppTextStyles.josefin(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1A1167),
                                    fontSize: 12.sp)),
                          ),
                          textField(
                              'Enter Your Job', 1, textFieldController[1]),
                          CustomSizeBox(5.h),
                          Text(
                            'Website',
                            style: AppTextStyles.josefin(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1A1167),
                                    fontSize: 12.sp)),
                          ),
                          textField(
                              'Enter Your Website', 2, textFieldController[2]),
                          CustomSizeBox(5.h),
                          Text(
                            'Cellphone',
                            style: AppTextStyles.josefin(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1A1167),
                                    fontSize: 12.sp)),
                          ),
                          // subText(user!.phone.toString()),
                          textField('Enter Your Phone No.', 3,
                              textFieldController[3]),
                          CustomSizeBox(5.h),
                          Text(
                            'Location',
                            style: AppTextStyles.josefin(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1A1167),
                                    fontSize: 12.sp)),
                          ),
                          // subText(user!.location),
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
                          textField('Your Hobbies', 6, textFieldController[6]),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 25.w, right: 25.w, bottom: 20.w),
                            child: GetButton(50.h, () async {
                              if(!readOnlyTextFields || imageEditAble) {
                                Functions.showLoaderDialog(context);
                                String? url;
                                if (image1 != null) {
                                  url =
                                  await Functions.uploadPic(image1!, "users");
                                }
                                await context.read<MyProfileController>()
                                    .updateUser(
                                    userName: textFieldController[5].text,
                                    company: textFieldController[0].text,
                                    position: textFieldController[1].text,
                                    cellPhone: textFieldController[3].text,
                                    website: textFieldController[2].text,
                                    location: textFieldController[4].text,
                                    pImage: url
                                );
                                Navigator.pop(context);
                                Functions.showSnackBar(context,
                                    "user profile updated successfully");
                                setState(() {
                                  readOnlyTextFields = !readOnlyTextFields;
                                  imageEditAble = !imageEditAble;
                                });
                              }else{
                                Functions.showSnackBar(context, "please edit profile");
                              }},
                                Text(
                                  'Save',
                                  style: AppTextStyles.josefin(
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700)),
                                )),
                          ),
                          GetButton(50.h, () async {
                           await FirebaseAuth.instance.signOut();
                           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>const LoginView()), (route) => false);
                          }, const Text("Log Out"))
                        ],
                      ),
                    ),
                  ),
                ))
              ])
            : const Center(child: CircularProgressIndicator()));
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
                    onTap: () async {
                      Navigator.pop(context);
                      final ImagePicker _picker = ImagePicker();
                      final XFile? pickedImage = await _picker.pickImage(
                          source: ImageSource.camera);
                      if (pickedImage != null) {
                        image1 = await pickedImage.readAsBytes();
                        setState(() {});
                      }
                }),
                selectPicCatagory("Files", Icons.folder, Colors.blue,
                    onTap: () {
                  // pickImageFromGallery()
                  //     .then((value) => Navigator.of(context).pop());
                }),
                selectPicCatagory("Gallery", Icons.image_outlined, Colors.white,
                    onTap: () async {
                      Navigator.pop(context);
                      final ImagePicker _picker = ImagePicker();
                      final XFile? pickedImage = await _picker.pickImage(
                          source: ImageSource.gallery);
                      if (pickedImage != null) {
                        image1 = await pickedImage.readAsBytes();
                        setState(() {});
                      }
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
        maxLines: index == 6 ? 4 : 1,
        readOnly: (readOnlyTextFields)?true:false,
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
  Widget subText(String text){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(text,style: TextStyle(color: Colors.deepPurple,fontSize: 11.sp),),
    );
  }
}
