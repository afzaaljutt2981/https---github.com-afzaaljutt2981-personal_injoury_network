class UserModel{
  late String firstName;
  late String lastName;
  late String company;
  late String position;
  late int phone;
  late String email;
  String? pImage;
  late String website;
  late String location;
  late String userName;
  late String id;
  late String userType;
  UserModel({
    required this.location,
    required this.position,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.id,
    this.pImage,
    required this.userName,
    required this.phone,
    required this.userType,
    required this.company,
    required this.website
});
 factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      userName: json['userName'],
        location: json['location'],
        position: json['position'],
        email: json['email'],
        id : json['id'],
        pImage: json['pImage'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        phone: json['phone'],
        company: json['company'],
        website: json['website'], userType: json['userType']);
  }
  Map<String,dynamic> toJson() {
  return {
    "firstName":firstName,
    "lastName":lastName,
    "company":company,
    "location":location,
    "pImage":pImage,
    "phone":phone,
    "id": id,
    "website":website,
    "email": email,
    "userType":userType,
    "userName":userName,
    "position":position
  };
  }
}