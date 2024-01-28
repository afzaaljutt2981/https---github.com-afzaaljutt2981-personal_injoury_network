import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/compaign_controller.dart';
import 'create_campaign_view.dart';

class CreateCampaignView extends StatefulWidget {
  const CreateCampaignView({super.key});

  @override
  State<CreateCampaignView> createState() => _CreateCampaignViewState();
}

class _CreateCampaignViewState extends State<CreateCampaignView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CampaignController>(
        create: (_) => CampaignController(), child: const CreateCampaign());
  }
}
