class CampaignModel {
  late String? id;
  List<String>? country;
  List<String>? jobOrPosition;
  late String? message;
  late String? title;
  late int? timeCreated;
  List<String?>? members;
  late String? pImage;
  late String? status;

  CampaignModel({
    required this.id,
    required this.country,
    required this.jobOrPosition,
    required this.message,
    required this.title,
    required this.timeCreated,
    required this.members,
    required this.pImage,
    required this.status,
  });

  factory CampaignModel.fromJson(Map<String, dynamic>? json) {
    List members = json?["members"] ?? [];
    List country = json?["country"] ?? [];
    List jobOrPosition = json?["jobOrPosition"] ?? [];
    return CampaignModel(
        id: json?['id'],
        country: List.generate(country.length, (index) => country[index]),
        jobOrPosition: List.generate(
            jobOrPosition.length, (index) => jobOrPosition[index]),
        message: json?['message'],
        title: json?['title'],
        timeCreated: json?['timeCreated'],
        members: List.generate(members.length, (index) => members[index]),
        pImage: json?['pImage'],
        status: json?['status']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "jobOrPosition": jobOrPosition,
        "message": message,
        "title": title,
        "timeCreated": timeCreated,
        "members": members,
        "pImage": pImage,
        "status": status
      };

  @override
  String toString() {
    return 'CampaignModel{id: $id, country: $country, jobOrPosition: $jobOrPosition, message: $message, title: $title, timeCreated: $timeCreated, members: $members, pImage: $pImage, status: $status}';
  }
}
