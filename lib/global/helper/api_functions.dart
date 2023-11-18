import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../ui/authentication/model/country_state_model.dart';
import '../utils/constants.dart';

class CountryStateCityRepo {
  static const countriesStateURL =
      'https://countriesnow.space/api/v0.1/countries/states';
  static const cityURL =
      'https://countriesnow.space/api/v0.1/countries/state/cities/q?country';

  Future<CountryStateModel> getCountriesStates() async {
    try {
      var url = Uri.parse(countriesStateURL);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final CountryStateModel responseModel =
            countryStateModelFromJson(response.body);
        return responseModel;
      } else {
        return CountryStateModel(
            error: true,
            msg: 'Something went wrong: ${response.statusCode}',
            data: []);
      }
    } catch (e) {
      log('Exception: ${e.toString()}');
      throw Exception(e.toString());
    }
  }
  static Future<http.Response> sendPushNotification(String title,String body,String fcmToken) async {
    Map<String,String> headers = {
      "Authorization": "key=${Constants.serverKey}",
      "Content-Type": "application/json",
    };
    Map<String, dynamic> notification = {
      'title': title,
      'body': body,
    };
    Map<String, dynamic> data = {
      'notification': notification,
      'to': fcmToken,
    };
    var response = await http.post(
        Uri.parse(Constants.fcmApi),
        headers: headers,
       body: jsonEncode(data)
    );
    print(response.statusCode);
    print("response is here");
    return response;
  }
}
