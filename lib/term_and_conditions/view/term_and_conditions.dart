import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:personal_injury_networking/ui/authentication/model/user_model.dart';
import 'package:personal_injury_networking/ui/notifications/model/nitofications_model.dart';

import '../../../global/utils/app_text_styles.dart';
import '../../global/utils/app_colors.dart';

class TermAndConditionsView extends StatefulWidget {
  const TermAndConditionsView({super.key});

  @override
  State<TermAndConditionsView> createState() => _TermAndConditionsViewState();
}

class _TermAndConditionsViewState extends State<TermAndConditionsView> {
  List<UserModel> allUsers = [];
  List<NotificationsModel> notiList = [];

  String formatDateTime(DateTime dateTime) {
    final dateFormat = DateFormat('E, h:mm a');
    return dateFormat.format(dateTime);
  }

  UserModel? currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Padding(
              padding: EdgeInsets.all(17.sp),
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
                  "Notifications",
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          color: const Color(0xFF120D26),
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          ),
          body: Center(
            child: CircularProgressIndicator(),
          )),
    );
  }
}
