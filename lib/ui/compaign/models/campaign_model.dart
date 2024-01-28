class CampaignModel {
  late String? id;
  late String? country;
  late String? jobOrPosition;
  late String? message;
  late DateTime? timeCreated;
  List<String?>? members;
  late String? pImage;
  late String? status;

  CampaignModel({
    required this.id,
    required this.country,
    required this.jobOrPosition,
    required this.message,
    required this.timeCreated,
    required this.members,
    required this.pImage,
    required this.status,
  });

  factory CampaignModel.fromJson(Map<String, dynamic>? json) {
    List members = json?["members"] ?? [];
    return CampaignModel(
        id: json?['id'],
        country: json?['country'],
        jobOrPosition: json?['jobOrPosition'],
        message: json?['message'],
        timeCreated: json?['dateTime'],
        members: List.generate(members.length, (index) => members[index]),
        pImage: json?['pImage'],
        status: json?['status']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "jobOrPosition": jobOrPosition,
        "message": message,
        "timeCreated": timeCreated,
        "members": members,
        "pImage": pImage,
        "status": status
      };
}
