class NotificationsModel {
  String? id;
  String? senderId;
  String? image;
  String? eId;
  String? notificationContent;
  int? time;
  String? status;
  String? notificationType;

  NotificationsModel({
    required this.id,
    required this.senderId,
    required this.image,
    required this.status,
    this.eId,
    required this.notificationContent,
    required this.time,
    required this.notificationType,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic>? json) {
    return NotificationsModel(
        id: json?['id'],
        senderId: json?['senderId'],
        image: json?['image'],
        notificationContent: json?['notificationContent'],
        time: json?['time'],
        eId: json?['eId'],
        status: json?['status'],
        notificationType: json?['notificationType']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "senderId": senderId,
        "image": image,
        "notificationContent": notificationContent,
        "time": time,
        "status": status,
        "eId": eId,
        "notificationType": notificationType
      };
}
