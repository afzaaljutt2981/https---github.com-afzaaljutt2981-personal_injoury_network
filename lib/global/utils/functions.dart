import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebasestorage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';

import 'app_strings.dart';
import 'package:http/http.dart' as http;
class Functions {
  static showSnackBar(BuildContext context, String message, {Color? color}) {
    color ??= Colors.white;
    final snackBar = SnackBar(
      backgroundColor: color, 
      content: Text(
        message,
        style: const TextStyle(
          color: AppColors.kPrimaryColor,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showLoaderDialog(BuildContext context, {String text = 'Loading'}) {
    AlertDialog alert = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        width: double.infinity,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Colors.white,
            )
          ],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<String> uploadPic(Uint8List file,String name,{String? contentType}) async {
    try {
      final firebasestorage.FirebaseStorage _storage =
          firebasestorage.FirebaseStorage.instance;
      var uid = FirebaseAuth.instance.currentUser!.uid;

      int mills = DateTime.now().millisecondsSinceEpoch;
      String mils = '$mills';
      var reference = _storage.ref().child(name).child(uid).child(mils);
      var r = await reference.putData(
          file, SettableMetadata(contentType: contentType??'image/jpeg'));
      if (r.state == firebasestorage.TaskState.success) {
        String url = await reference.getDownloadURL();
        return url;
      } else {
        throw PlatformException(
            code: "404", message: AppStrings.noDownloadLinkFound);
      }
    } catch (e) {
      rethrow;
    }
  }

  static showDialogueBox(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.sp),
              ),
              title: Column(
                children: [
                  Image(
                      width: 40.sp,
                      height: 40.sp,
                      image: const AssetImage(
                          'assets/images/question_icon_drawer.png')),
                  CustomSizeBox(15.h),
                  Text(
                    "Your account is suspended by admin.",
                    style: AppTextStyles.josefin(
                        style: TextStyle(
                            height: 1.3.sp,
                            color: AppColors.kBlackColor,
                            fontSize: 14.sp)),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, "ok");
                      // context.read<MyProfileController>().becomeMarketer();
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     PageTransition(
                      //       childCurrent: widget,
                      //       type: PageTransitionType.leftToRightJoined,
                      //       alignment: Alignment.center,
                      //       duration: const Duration(milliseconds: 200),
                      //       reverseDuration:
                      //       const Duration(milliseconds: 200),
                      //       child: BottomNavigationScreen(
                      //         selectedIndex: 0,
                      //       ),
                      //     ),
                      //         (route) => false);
                      // setState(() {
                      //   userType = 'admin';
                      //   Navigator.pushAndRemoveUntil(
                      //       context,
                      //       PageTransition(
                      //         childCurrent: widget,
                      //         type: PageTransitionType.leftToRightJoined,
                      //         alignment: Alignment.center,
                      //         duration: const Duration(milliseconds: 200),
                      //         reverseDuration:
                      //             const Duration(milliseconds: 200),
                      //         child: BottomNavigationScreen(
                      //           selectedIndex: 0,
                      //         ),
                      //       ),
                      //       (route) => false);
                      // });
                    },
                    child: Text(
                      "Continue",
                      style: AppTextStyles.josefin(
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.kPrimaryColor,
                            fontSize: 14.sp),
                      ),
                    )),
              ],
            ),
          );
        });
  }


}
