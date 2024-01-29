import 'package:personal_injury_networking/ui/compaign/models/campaign_model.dart';
import 'package:personal_injury_networking/ui/notifications/model/nitofications_model.dart';

class GenericDataModel {
  NotificationsModel? notificationsModel;
  CampaignModel? campaignModel;
  String? notificationType;

  GenericDataModel({
    required this.notificationsModel,
    required this.campaignModel,
    required this.notificationType,
  });
}
