import 'package:flutter/material.dart';
import 'package:personal_injury_networking/ui/compaign/models/campaign_model.dart';
import 'package:provider/provider.dart';

import '../controller/compaign_controller.dart';
import 'campaign_user_view.dart';

class ViewCampaignView extends StatefulWidget {
  ViewCampaignView({super.key, required this.campaignModel});

  CampaignModel? campaignModel;

  @override
  State<ViewCampaignView> createState() => _ViewCampaignViewState();
}

class _ViewCampaignViewState extends State<ViewCampaignView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CampaignController>(
        create: (_) => CampaignController(),
        child: ViewCampaign(
          campaignModel: widget.campaignModel,
        ));
  }
}
