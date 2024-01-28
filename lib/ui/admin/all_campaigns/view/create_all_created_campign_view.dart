import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/allCreatedCapaignsController.dart';
import 'all_created_campaign_view.dart';

class CreateAllCreatedCampaignView extends StatefulWidget {
  const CreateAllCreatedCampaignView({super.key});

  @override
  State<CreateAllCreatedCampaignView> createState() =>
      _CreateAllCreatedCampaignViewState();
}

class _CreateAllCreatedCampaignViewState
    extends State<CreateAllCreatedCampaignView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AllCreatedCampaignsController>(
        create: (_) => AllCreatedCampaignsController(),
        child: const AllCreatedCampaignsScreen());
  }
}
