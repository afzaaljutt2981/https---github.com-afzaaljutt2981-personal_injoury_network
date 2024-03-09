import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_injury_networking/global/helper/image_view.dart';
import 'package:personal_injury_networking/global/utils/app_colors.dart';
import 'package:personal_injury_networking/global/utils/app_text_styles.dart';
import 'package:personal_injury_networking/ui/compaign/models/campaign_model.dart';
import 'package:readmore/readmore.dart';

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
    final test = widget.campaignModel?.pImage ?? "";
    return SafeArea(
      child: Scaffold(
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
                (widget.campaignModel?.title?.length ?? 0) > 20
                    ? "${(widget.campaignModel?.title?.substring(0, 20) ?? "")}..."
                    : widget.campaignModel?.title ?? "",
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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ImageView(
                              imageUrl: widget.campaignModel?.pImage ?? "")));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 1.7,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    image: DecorationImage(
                      image: NetworkImage(widget.campaignModel?.pImage ?? ""),
                      // Replace with your image URL
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    Text(
                      'Details :',
                      style: TextStyle(
                        color: Color(0xFF16183B),
                        fontSize: 14,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: 0.28,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    ReadMoreText(
                      widget.campaignModel?.message ?? "",
                      trimLines: 4,
                      // colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: ' Show more',
                      trimExpandedText: ' Show less',

                      preDataTextStyle: TextStyle(
                        color: Color(0xFF3C3760),
                        fontSize: 11,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w500,
                        height: 0.15,
                        letterSpacing: 0.22,
                      ),
                      postDataTextStyle: TextStyle(
                        color: Color(0xFF3C3760),
                        fontSize: 11,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w500,
                        height: 0.15,
                        letterSpacing: 0.22,
                      ),
                      moreStyle: TextStyle(
                          fontSize: 14,
                          // decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kPrimaryColor),
                      lessStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kPrimaryColor),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
