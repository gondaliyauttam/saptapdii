// To parse this JSON data, do
//
//     final successData = successDataFromJson(jsonString);

import 'dart:convert';

SuccessData successDataFromJson(String str) => SuccessData.fromJson(json.decode(str));

String successDataToJson(SuccessData data) => json.encode(data.toJson());

class SuccessData {
  SuccessData({
    this.statusCode,
    this.msg,
  });

  int statusCode;
  String msg;

  factory SuccessData.fromJson(Map<String, dynamic> json) => SuccessData(
    statusCode: json["status_code"] == null ? null : json["status_code"],
    msg: json["msg"] == null ? null : json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode == null ? null : statusCode,
    "msg": msg == null ? null : msg,
  };
}
