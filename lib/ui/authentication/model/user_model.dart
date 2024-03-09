class UserModel {
  late String? firstName;
  late String? lastName;
  late String? company;
  late String? position;
  late int? phone;
  late String? email;
  String? pImage;
  late String? website;
  bool? showSimpleNotification;
  bool? showMessageNotification;
  late String? location;
  late String? country;
  late String? county;
  late String? userName;
  late String? id;
  late String? reference;
  late String? userType;
  late String? fcmToken;
  List<String?>? hobbies = [];
  List<String?>? followers = [];
  List<String?>? followings = [];
  List<String?>? followingRequests = [];
  bool? isDeleted = false;
  bool? isNewNotificationReceived = false;
  late int? timeCreated;

  UserModel({
    required this.location,
    required this.country,
    required this.county,
    required this.position,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.reference,
    this.showSimpleNotification,
    this.showMessageNotification,
    required this.hobbies,
    required this.followers,
    required this.followingRequests,
    required this.followings,
    this.pImage,
    this.fcmToken,
    required this.userName,
    required this.phone,
    required this.userType,
    required this.company,
    required this.website,
    this.isDeleted,
    required this.isNewNotificationReceived,
    required this.timeCreated,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    List hobbies = json?['hobbies'] ?? [];
    List followers = json?['followers'] ?? [];
    List followings = json?['followings'] ?? [];
    List followingRequests_ = json?['followingRequests'] ?? [];
    return UserModel(
      userName: json?['userName'],
      location: json?['location'],
      country: json?['country'],
      county: json?['county'],
      position: json?['position'],
      email: json?['email'],
      id: json?['id'],
      fcmToken: json?['fcmToken'],
      pImage: json?['pImage'],
      showSimpleNotification: json?["showSimpleNotification"] ?? false,
      showMessageNotification: json?["showMessageNotification"] ?? false,
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
      followingRequests: List.generate(
          followingRequests_.length, (index) => followingRequests_[index]),
      isDeleted: json?['isDeleted'],
      isNewNotificationReceived: json?['isNewNotificationReceived'],
      timeCreated: json?['timeCreated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "company": company,
      "location": location,
      "country": country,
      "county": county,
      "pImage": pImage,
      "phone": phone,
      "id": id,
      "website": website,
      "email": email,
      "fcmToken": fcmToken,
      "showNotification": showSimpleNotification ?? false,
      "showMessageNotification": showMessageNotification ?? false,
      "reference": reference,
      "userType": userType,
      "userName": userName,
      "position": position,
      "hobbies": hobbies,
      "followers": followers,
      "followings": followings,
      "followingRequests": followingRequests,
      "isDeleted": isDeleted,
      "isNewNotificationReceived": isNewNotificationReceived,
      "timeCreated": timeCreated,
    };
  }

  @override
  String toString() {
    return 'UserModel{firstName: $firstName, lastName: $lastName, company: $company, position: $position, phone: $phone, email: $email, pImage: $pImage, website: $website, showSimpleNotification: $showSimpleNotification, showMessageNotification: $showMessageNotification, location: $location, country: $country, county: $county, userName: $userName, id: $id, reference: $reference, userType: $userType, fcmToken: $fcmToken, hobbies: $hobbies, followers: $followers, followings: $followings, followingRequests: $followingRequests, isDeleted: $isDeleted, isNewNotificationReceived: $isNewNotificationReceived, timeCreated: $timeCreated}';
  }
}
