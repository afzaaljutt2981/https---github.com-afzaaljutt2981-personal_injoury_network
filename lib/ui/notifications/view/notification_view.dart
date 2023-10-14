import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/helper/custom_sized_box.dart';
import 'package:personal_injury_networking/ui/notifications/model/nitofications_model.dart';

import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<NotificationsModel> notiList = [
    NotificationsModel('assets/images/profile_pic.png',
        'David Silbia Invite Jo Malone London’s Mother’s ', 'Just now', '1'),
    NotificationsModel('assets/images/profile_pic.png',
        'Adnan Safi  Started following you', '5 min ago', '0'),
    NotificationsModel(
        'assets/images/profile_pic.png',
        'Joan Baker Invite A virtual Evening of Smooth Jazz',
        '15 min ago',
        '1'),
    NotificationsModel('assets/images/profile_pic.png',
        'Ronald C. Kinch Like you events', '25 min ago', '0'),
    NotificationsModel('assets/images/profile_pic.png',
        'Clara Tolson Join your Event Gala Music Festival', 'Just now', '0'),
    NotificationsModel(
        'assets/images/profile_pic.png',
        'Jennifer Fritz Invite you International Kids Safe ',
        'Tue, 5:10pm',
        '1'),
    NotificationsModel('assets/images/profile_pic.png',
        'Eric G. Prickett Started following you', 'Wed, 3:30 pm', '0'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: EdgeInsets.all(17.sp),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back_ios,
                color: const Color(0xFF120D26),
                size: 18.sp,
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
        body: notiList.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomSizeBox(100.h),
                  Center(
                    child: Image(
                      height: 300.sp,
                      width: 250.sp,
                      image: const AssetImage(
                          'assets/images/no_notification_screen.png'),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: notiList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var model = notiList[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 12.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image(
                                    height: 45.sp,
                                    width: 45.sp,
                                    image: AssetImage(model.image),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CustomSizeBox(4.h),
                                          Text(
                                            model.notificationContent,
                                            style: AppTextStyles.josefin(
                                                style: TextStyle(
                                                    color:
                                                        AppColors.kBlackColor,
                                                    fontSize: 14.sp)),
                                          ),
                                          CustomSizeBox(10.h),
                                          model.notiType == '1'
                                              ? Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: const Color(
                                                                  0xFFEEEEEE)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      7.sp)),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    27.w,
                                                                vertical: 9.h),
                                                        child: Text(
                                                          'Reject',
                                                          style: AppTextStyles.josefin(
                                                              style: TextStyle(
                                                                  color: const Color(
                                                                      0xFF706D6D),
                                                                  fontSize:
                                                                      12.sp)),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 8.w,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .kPrimaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      7.sp)),
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    27.w,
                                                                vertical: 9.h),
                                                        child: Text(
                                                          'Accept',
                                                          style: AppTextStyles.josefin(
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12.sp)),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.h),
                                    child: Text(
                                      model.time,
                                      style: AppTextStyles.josefin(
                                          style: TextStyle(
                                              fontSize: 11.sp,
                                              color: AppColors.kBlackColor)),
                                    ),
                                  )
                                ],
                              ),
                            );
                          })),
                ],
              ));
  }
}



// Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image(
//               height: 45.sp,
//               width: 45.sp,
//               image: const AssetImage('assets/images/profile_pic.png'),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 12.w),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     CustomSizeBox(4.h),
//                     Text(
//                       'David Silbia Invite Jo Malone London’s Mother’s ',
//                       style: AppTextStyles.josefin(
//                           style: TextStyle(
//                               color: AppColors.kBlackColor, fontSize: 14.sp)),
//                     ),
//                     CustomSizeBox(10.h),
//                     Row(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               border:
//                                   Border.all(color: const Color(0xFFEEEEEE)),
//                               borderRadius: BorderRadius.circular(7.sp)),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 30.w, vertical: 9.h),
//                             child: Text(
//                               'Reject',
//                               style: AppTextStyles.josefin(
//                                   style: TextStyle(
//                                       color: const Color(0xFF706D6D),
//                                       fontSize: 12.sp)),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 8.w,
//                         ),
//                         Container(
//                           decoration: BoxDecoration(
//                               color: AppColors.kPrimaryColor,
//                               borderRadius: BorderRadius.circular(7.sp)),
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 30.w, vertical: 9.h),
//                             child: Text(
//                               'Accept',
//                               style: AppTextStyles.josefin(
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 12.sp)),
//                             ),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(top: 5.h),
//               child: Text(
//                 'Just now',
//                 style: AppTextStyles.josefin(
//                     style: const TextStyle(color: AppColors.kBlackColor)),
//               ),
//             )
//           ],
//         )