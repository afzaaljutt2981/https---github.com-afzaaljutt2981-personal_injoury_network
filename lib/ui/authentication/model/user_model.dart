class UserModel{
  late String firstName;
  late String lastName;
  late String company;
  late String position;
  late int phone;
  late String email;
  late String website;
  late String location;
  late String userName;
  late String id;
  UserModel({
    required this.location,
    required this.position,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.userName,
    required this.phone,
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
        firstName: json['firstName'],
        lastName: json['lastName'],
        phone: json['phone'],
        company: json['company'],
        website: json['website']);
  }
  Map<String,dynamic> toJson() {
  return {
    "firstName":firstName,
    "lastName":lastName,
    "company":company,
    "location":location,
    "phone":phone,
    "id": id,
    "website":website,
    "email": email,
    "userName":userName,
    "position":position
  };
  }
}