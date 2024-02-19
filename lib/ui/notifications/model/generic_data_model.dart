import 'package:personal_injury_networking/ui/compaign/models/campaign_model.dart';
import 'package:personal_injury_networking/ui/notifications/model/nitofications_model.dart';

class GenericDataModel {
  NotificationsModel? notificationsModel;
  CampaignModel? campaignModel;
  String? notificationType;
  int? timeCreated;
  GenericDataModel({
    required this.notificationsModel,
    required this.campaignModel,
    required this.notificationType,
    required this.timeCreated,
  });

  @override
  String toString() {
    return 'GenericDataModel{notificationsModel: $notificationsModel, campaignModel: $campaignModel, notificationType: $notificationType, timeCreated: $timeCreated}';
  }
}
