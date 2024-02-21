import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';
import 'package:personal_injury_networking/ui/compaign/models/campaign_model.dart';

class ViewCampaign extends StatefulWidget {
  ViewCampaign({super.key, required this.campaignModel});

  CampaignModel? campaignModel;

  @override
  State<ViewCampaign> createState() => _ViewCampaign();
}

class _ViewCampaign extends State<ViewCampaign> {
  // Sample data for the campaign
  final String imageUrl = 'https://via.placeholder.com/150';
  final String message = 'Join our annual charity run!';
  final String date = 'March 1, 2024';
  final String time = '10:00 AM';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.sp),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              width: 100.sp,
              height: 40.sp,
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: const Color(0xFF120D26),
                  size: 18.sp,
                ),
              ),
            ),
          ),
        ),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 45.w),
            child: Text(
              "Campaign",
              style: AppTextStyles.josefin(
                  style: TextStyle(
                      color: const Color(0xFF120D26),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Add this line
        children: <Widget>[
          Image.network(
            widget.campaignModel?.pImage ?? "",
            fit: BoxFit.cover,
            // This will ensure the image covers the width of the screen
            width: MediaQuery.of(context).size.width,
            // This matches the image width to the screen width
            height: 200, // You can adjust the height as needed
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 8.0),
                Center(
                  child: Text(
                    "Campaign Message",
                    style: AppTextStyles.josefin(
                        style: TextStyle(
                            color: AppColors.kBlackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500)),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  "${widget.campaignModel?.message}",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 8.0),
                const Divider(),
                Center(
                  child: Text(
                    "Creation Information",
                    style: AppTextStyles.josefin(
                        style: TextStyle(
                            color: AppColors.kBlackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500)),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(),
                Text(
                  'Date: ${DateFormat('EEE,MMM d').format(DateTime.fromMicrosecondsSinceEpoch(widget.campaignModel?.timeCreated ?? 0))}',
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          color: AppColors.kBlackColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(height: 8.0),
                const Divider(),
                Text(
                  'Time: ${DateFormat('E, h:mm a').format(DateTime.fromMicrosecondsSinceEpoch(widget.campaignModel?.timeCreated ?? 0))}',
                  style: AppTextStyles.josefin(
                      style: TextStyle(
                          color: AppColors.kBlackColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
