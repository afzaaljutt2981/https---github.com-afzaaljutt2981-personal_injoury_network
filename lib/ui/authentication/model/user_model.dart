class UserModel {
  late String? firstName;
  late String? lastName;
  late String? company;
  late String? position;
  late int? phone;
  late String? email;
  String? pImage;
  late String? website;
  bool? showNotification;
  late String? location;
  late String? userName;
  late String? id;
  late String? reference;
  late String? userType;
  late String? fcmToken;
  List<String?>? hobbies = [];
  List<String?>? followers = [];
  List<String?>? followings = [];
  bool? isDeleted = false;

  UserModel(
      {required this.location,
      required this.position,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.id,
      required this.reference,
         this.showNotification,
      required this.hobbies,
      required this.followers,
      required this.followings,
      this.pImage,
      this.fcmToken,
      required this.userName,
      required this.phone,
      required this.userType,
      required this.company,
      required this.website,
      this.isDeleted});

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    List hobbies = json?['hobbies'] ?? [];
    List followers = json?['followers'] ?? [];
    List followings = json?['followings'] ?? [];
    return UserModel(
      userName: json?['userName'],
      location: json?['location'],
      position: json?['position'],
      email: json?['email'],
      id: json?['id'],
      fcmToken: json?['fcmToken'],
      pImage: json?['pImage'],
      showNotification: json?["showNotification"]??false,
      firstName: json?['firstName'],
      lastName: json?['lastName'],
      phone: json?['phone'],
      reference: json?['reference'],
      company: json?['company'],
      website: json?['website'],
      userType: json?['userType'],
      hobbies: List.generate(hobbies.length, (index) => hobbies[index]),
      followings:
          List.generate(followings.length, (index) => followings[index]),
      followers: List.generate(followers.length, (index) => followers[index]),
      isDeleted: json?['isDeleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "company": company,
      "location": location,
      "pImage": pImage,
      "phone": phone,
      "id": id,
      "website": website,
      "email": email,
      "fcmToken": fcmToken,
      "showNotification":showNotification??false,
      "reference": reference,
      "userType": userType,
      "userName": userName,
      "position": position,
      "hobbies": hobbies,
      "followers": followers,
      "followings": followings,
      "isDeleted": isDeleted
    };
  }
}
