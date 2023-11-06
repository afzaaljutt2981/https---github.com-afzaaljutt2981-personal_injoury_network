import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:personal_injury_networking/ui/events_details/view/scaning_screen.dart';

import '../../../global/app_buttons/white_background_button.dart';
import '../../../global/utils/app_colors.dart';
import '../../../global/utils/app_text_styles.dart';

class EventsQrView extends StatefulWidget {
   EventsQrView({ required this.eventId,  super.key});
  var eventId;
  @override
  State<EventsQrView> createState() => _EventsQrViewState();
}

class _EventsQrViewState extends State<EventsQrView> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: Stack(
        children: [
          Container(color: Colors.white, height: screenHeight),
          Positioned(
            top: 0,
            child: Container(
              color: AppColors.kPrimaryColor,
              width: screenWidth,
              height: screenHeight,
              child: Align(
                alignment: Alignment.topRight,
                child: Image(
                  height: 175.sp,
                  width: 172.sp,
                  image: const AssetImage(
                      'assets/images/home_background_graph.png'),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.19,
            left: screenWidth * 0.1,
            child: Image(
              height: 285.sp,
              width: 282.sp,
              image: const AssetImage('assets/images/scan_events_qr_view.png'),
            ),
          ),
          Positioned(
              top: screenHeight * 0.65,
              left: screenWidth * 0.33,
              child: Text(
                "Scan QR Code",
                style: AppTextStyles.josefin(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800)),
              )),
          Padding(
            padding: EdgeInsets.only(
                top: screenHeight * 0.82, left: 30.w, right: 30.w),
            child: GetwhiteButton(50.sp, () {
              Navigator.push(
                context,
                PageTransition(
                  childCurrent: widget,
                  type: PageTransitionType.bottomToTop,
                  alignment: Alignment.center,
                  duration: const Duration(milliseconds: 200),
                  reverseDuration: const Duration(milliseconds: 200),
                  child: QRScannerScreen(eventId: widget.eventId,),
                ),
              );
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const EventScanQrScreen()));
            },
                Text(
                  "QR Scan",
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          color: AppColors.kPrimaryColor, fontSize: 18.sp)),
                )),
          ),
        ],
      ),
    );
  }
}
