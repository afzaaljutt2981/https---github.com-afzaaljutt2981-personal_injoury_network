class EventModel {
  late String id;
  late String title;
  late String address;
  late String description;
  late int dateTime;
  late int startTime;
  late int endTime;
  late String pImage;
  late String uId;
  double latitude;
  double longitude;

  EventModel({
    required this.endTime,
    required this.startTime,
    required this.id,
    required this.address,
    required this.description,
    required this.title,
    required this.dateTime,
    required this.pImage,
    required this.longitude,
    required this.latitude,
    required this.uId,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        endTime: json['endTime'],
        startTime: json['startTime'],
        id: json['id'],
        address: json['address'],
        description: json['description'],
        title: json['title'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        dateTime: json['dateTime'],
        pImage: json['pImage'],
        uId: json['uId']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "endTime": endTime,
        "startTime": startTime,
        "address": address,
        "description": description,
        "title": title,
        "dateTime": dateTime,
        "latitude": latitude,
        "longitude": longitude,
        "pImage": pImage,
        "uId": uId
      };
}
