// To parse this JSON data, do
//
//     final adsData = adsDataFromJson(jsonString);

import 'dart:convert';

AdsData adsDataFromJson(String str) => AdsData.fromJson(json.decode(str));

String adsDataToJson(AdsData data) => json.encode(data.toJson());

class AdsData {
  AdsData({
    this.statusCode,
    this.msg,
    this.popupScreenBanner,
  });

  int statusCode;
  String msg;
  PopupScreenBanner popupScreenBanner;

  factory AdsData.fromJson(Map<String, dynamic> json) => AdsData(
    statusCode: json["status_code"] == null ? null : json["status_code"],
    msg: json["msg"] == null ? null : json["msg"],
    popupScreenBanner: json["popup_screen_banner"] == null ? null : PopupScreenBanner.fromJson(json["popup_screen_banner"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode == null ? null : statusCode,
    "msg": msg == null ? null : msg,
    "popup_screen_banner": popupScreenBanner == null ? null : popupScreenBanner.toJson(),
  };
}

class PopupScreenBanner {
  PopupScreenBanner({
    this.id,
    this.name,
    this.url,
    this.upProImg,
  });

  String id;
  String name;
  String url;
  String upProImg;

  factory PopupScreenBanner.fromJson(Map<String, dynamic> json) => PopupScreenBanner(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    url: json["url"] == null ? null : json["url"],
    upProImg: json["up_pro_img"] == null ? null : json["up_pro_img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "url": url == null ? null : url,
    "up_pro_img": upProImg == null ? null : upProImg,
  };
}
