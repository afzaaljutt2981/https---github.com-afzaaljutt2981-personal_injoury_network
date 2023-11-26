import 'dart:io';

class Constants {
  static String userType = 'user';
  static String userName = '';
  static String userPosition = '';
  static String userDisplayName = '';
  static String userEmail = '';
  static String fcmToken = '';
  static String fcmApi = "https://fcm.googleapis.com/fcm/send";
  static String serverKey =
      "AAAAE6FoIbo:APA91bGMPm3jMAdTCQoglmHBWubAQkyV1dkCd32ieRmtoCeGwNN3jMpNwzd85kK5fW-emSFX594MB5EVnOJi55rIxq46n0PEqbwNw9bFxSRJaFNd9wZgzgagg_Z0HzalF6VjwjfIIYwq";
  static String uId = '';
  static String mapKey = Platform.isAndroid
      ? "AIzaSyDielMrqePDtgCxZUHSbWkKr4SyTZjXWAk"
      : "AIzaSyCct6Mn9T-U4-wclBHsL7mx2hp1JII8kkA";

  static String adminEmail = "wsshoppingclub@gmail.com";
  // static String adminEmail = "ali.usman32332@gmail.com";
}
