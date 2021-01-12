import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:intl/intl.dart';
import 'package:saptapadi/model/success_data.dart';
import 'package:saptapadi/model/wedding_profile_data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

WeddingProfile currentUser;


Future<WeddingProfile> weddingprofile({String mobile}) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_wedding_profile';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': mobile,
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;

    currentUser = weddingProfileFromJson(res);
  }
  return currentUser;
}

void setCurrentUserMobile(mobile) async {
  if (mobile != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_user_mobile', mobile);
  }
}

Future<String> getCurrentUserMobile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String mobile;
  if (prefs.containsKey('current_user_mobile')) {
    mobile = await prefs.get('current_user_mobile');
  }
  return mobile;
}

Future<SuccessData> profileUpdate(WeddingProfile weddingProfile) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_wedding_profile_update';
  final client = new http.Client();
  final response = await client.post(url,
      body: jsonEncode(weddingProfile.weddingProfile.toProfileDataJson()));
  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}

Future<SuccessData> asyncFileUpload(File file) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_wedding_profile_image_update';
  var request = http.MultipartRequest(
    "POST",
    Uri.parse(url),
  );
  request.headers.addAll({HttpHeaders.contentTypeHeader: 'application/json'});

  var pic = await http.MultipartFile.fromPath("profile_img", file.path);
  //add multipart to request
  request.fields['user_mobile'] = currentUser.weddingProfile.userMobile;
  request.files.add(pic);
  var response = await request.send();

  //Get the response from the server
  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);

  return successDataFromJson(json.decode(responseString));
}

String getDate(selectedDate) {
  DateTime tempDate =
  new DateFormat("yyyy-MM-dd hh:mm:ss").parse(selectedDate, true);
  String date = DateFormat("MMM.dd,yyyy").format(tempDate);
  return date;
}