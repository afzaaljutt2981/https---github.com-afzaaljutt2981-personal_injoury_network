import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';

import '../../global/helper/text_field.dart';
import '../../global/utils/app_colors.dart';
import '../../global/utils/app_text_styles.dart';

class BasicInfo extends StatefulWidget {
  BasicInfo(this.fName, this.lName, this.emal);
  String fName;
  String lName;
  String emal;
  @override
  State<BasicInfo> createState() => _BasicInfoState();
}

final _forkey = GlobalKey<FormState>();
DateTime selectedDate = DateTime.now();
bool _editAble = false;
TextEditingController fname = TextEditingController();
TextEditingController lname = TextEditingController();
TextEditingController dob = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController cell = TextEditingController();

class _BasicInfoState extends State<BasicInfo> {
  String? profilePicUrl;
  //XFile? file;
  // Future pickImageFromCamera() async {
  //   XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
  //   setState(() {
  //     file = image;
  //   });
  // }
  @override
  // Future pickImageFromGallery() async {
  //   XFile? oimage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     file = oimage;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    fname.text = widget.fName;
    lname.text = widget.lName;
    email.text = widget.emal;
    cell.text = '+9266630642981';
  }

  String uniqueNameClass = DateTime.now().millisecondsSinceEpoch.toString();

  // Future uploadFile() async {
  //   if (file == null) return;
  //   Reference referenceRoot = FirebaseStorage.instance.ref();
  //   Reference refrenceDirImages = referenceRoot
  //       .child(FirebaseAuth.instance.currentUser!.uid)
  //       .child("basicInfo")
  //       .child(uniqueNameClass);

  //   try {
  //     await refrenceDirImages.putFile(File(file!.path));
  //     profilePicUrl = await refrenceDirImages.getDownloadURL();

  //   } catch (e) {

  //   }
  //   return profilePicUrl;
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        // AppBar

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              "User Profile",
              style: AppTextStyles.josefin(
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF120D26))),
            ),
          ),
        ),

        //body
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _forkey,
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0),
                          spreadRadius: 2,
                          blurRadius: 4,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    width: screenWidth * 0.95,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Pic

                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: InkWell(
                              onTap: () {
                                _editAble ? showBottomModelSheetWidget() : null;
                              },
                              child: Center(
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      //color: Colors.red,
                                      height: 125.sp,
                                      width: 130.sp,
                                    ),
                                    CircleAvatar(
                                      radius: 60.sp,
                                      backgroundImage: const AssetImage(
                                          "assets/images/profile_pic.png"),
                                      // child: file == null
                                      //     ? (value.infoUser != null)?
                                      //        CircleAvatar(
                                      //     radius: 78,
                                      //     backgroundColor: Colors.white,
                                      //     backgroundImage: NetworkImage(value.infoUser!.profileImage) ) :
                                      //      const CircleAvatar(

                                      //     radius: 78,
                                      //     backgroundImage: AssetImage(
                                      //         "assets/images/extra/profilePic.png"))                                    //     ? (value.infoUser!.profileImage != null)

                                      //     : ClipRRect(
                                      //   borderRadius: BorderRadius.circular(100),
                                      //   child: Image.file(
                                      //     File(file!.path),
                                      //     fit: BoxFit.cover,
                                      //     width: 400,
                                      //   ),
                                      // )
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: 64.sp,
                                      child: _editAble
                                          ? Container(
                                              decoration: const BoxDecoration(
                                                  color:
                                                      AppColors.kPrimaryColor,
                                                  shape: BoxShape.circle),
                                              child: Padding(
                                                padding: EdgeInsets.all(4.sp),
                                                child: Icon(
                                                  Icons.edit,
                                                  size: 20.sp,
                                                  color: Colors.white,
                                                ),
                                              ))
                                          : const SizedBox(),
                                    ),
                                  ],
                                ),
                              )),
                        ),

                        // Add Photo container
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _editAble = true;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    border: Border.all(
                                        color: AppColors.kPrimaryColor,
                                        width: 2)),
                                //  color: Colors.red,
                                width: screenWidth * 0.4,
                                height: screenHeight * 0.04,
                                child: Center(
                                  child: Text(
                                    "Edit Profile",
                                    style: AppTextStyles.josefin(
                                        style: const TextStyle(
                                            color: AppColors.kPrimaryColor,
                                            fontSize: 14)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            "First Name",
                            style: AppTextStyles.josefin(
                                style: const TextStyle(
                                    color: AppColors.kBlackColor,
                                    fontSize: 16)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 12, top: 0),
                          child: TextFieldClass(
                            icon: Icon(
                              Icons.person,
                              color: AppColors.kPrimaryColor,
                              size: 22.sp,
                            ),
                            // label: "First Name",
                            editAble: _editAble,
                            hinText: "James",
                            fieldController: fname,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            "Last Name",
                            style: AppTextStyles.josefin(
                                style: const TextStyle(
                                    color: AppColors.kBlackColor,
                                    fontSize: 16)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 12, top: 0),
                          child: TextFieldClass(
                            icon: Icon(
                              Icons.person,
                              color: AppColors.kPrimaryColor,
                              size: 22.sp,
                            ),
                            // label: "Last Name",
                            editAble: _editAble,
                            hinText: "Bonds",
                            fieldController: lname,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            "Cell Phone",
                            style: AppTextStyles.josefin(
                                style: const TextStyle(
                                    color: AppColors.kBlackColor,
                                    fontSize: 16)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 12, top: 0),
                          child: TextFieldClass(
                            icon: Icon(
                              Icons.phone,
                              color: AppColors.kPrimaryColor,
                              size: 22.sp,
                            ),
                            //   label: "Cell Phone",
                            editAble: _editAble,
                            hinText: "+9 30303 848548338",
                            fieldController: cell,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 15),
                          child: Text(
                            "Email",
                            style: AppTextStyles.josefin(
                                style: const TextStyle(
                                    color: AppColors.kBlackColor,
                                    fontSize: 16)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 12, top: 0),
                          child: TextFieldClass(
                            icon: Icon(
                              Icons.email_outlined,
                              color: AppColors.kPrimaryColor,
                              size: 22.sp,
                            ),
                            //  label: "Email",
                            editAble: _editAble,
                            hinText: "afzaal@gmail.com",
                            fieldController: email,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Next Button
                SizedBox(
                  height: screenHeight * 0.02,
                ),

                _editAble
                    ? Container(
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.87,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.kPrimaryColor,
                        ),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50)))),
                          onPressed: () async {
                            setState(() {
                              _editAble = !_editAble;
                            });
                            //   if (_forkey.currentState!.validate()) {
                            //     LoadingDialogue.showLoaderDialog(context);
                            //     profilePicUrl = await uploadFile();
                            //     if (profilePicUrl == null) {
                            //     if  (value.infoUser?.profileImage == null){
                            //       // ignore: use_build_context_synchronously
                            //       Navigator.pop(context);
                            //       // ignore: use_build_context_synchronously
                            //       newSnackBar(context,"Profile picture required");
                            //     }
                            //     else{
                            //       await value.paramedicBasicInfo(fname.text, lname.text, selectedDate.millisecondsSinceEpoch, value.infoUser!.profileImage, email.text );

                            //       // ignore: use_build_context_synchronously
                            //       Navigator.pop(context);
                            //       // ignore: use_build_context_synchronously
                            //       newSnackBar(context, "data saved");
                            //     }

                            //     }
                            //     else
                            //     {
                            //       await value.paramedicBasicInfo(fname.text, lname.text, selectedDate.millisecondsSinceEpoch, profilePicUrl!, email.text );

                            //  // ignore: use_build_context_synchronously
                            //  Navigator.pop(context);
                            //       // ignore: use_build_context_synchronously
                            //       newSnackBar(context, "data saved");
                            //     }
                            //   }
                            //    else{
                            //     }
                          },
                          child: Text(
                            "Save Changes",
                            style: AppTextStyles.josefin(
                                style: TextStyle(
                                    color: AppColors.kWhiteColor,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ))
                    : const SizedBox(),

                // term and conditions
                SizedBox(
                  height: screenHeight * 0.02,
                ),
              ],
            ),
          ),
        ));
  }

  // Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
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
}
