// To parse this JSON data, do
//
//     final notificationData = notificationDataFromJson(jsonString);

import 'dart:convert';

NotificationData notificationDataFromJson(String str) => NotificationData.fromJson(json.decode(str));

String notificationDataToJson(NotificationData data) => json.encode(data.toJson());

class NotificationData {
  NotificationData({
    this.statusCode,
    this.msg,
    this.notificationList,
    this.notificationBanner,
  });

  int statusCode;
  String msg;
  List<NotificationList> notificationList;
  List<NotificationBanner> notificationBanner;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    statusCode: json["status_code"] == null ? null : json["status_code"],
    msg: json["msg"] == null ? null : json["msg"],
    notificationList: json["notification_list"] == null ? null : List<NotificationList>.from(json["notification_list"].map((x) => NotificationList.fromJson(x))),
    notificationBanner: json["notification_banner"] == null ? null : List<NotificationBanner>.from(json["notification_banner"].map((x) => NotificationBanner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode == null ? null : statusCode,
    "msg": msg == null ? null : msg,
    "notification_list": notificationList == null ? null : List<dynamic>.from(notificationList.map((x) => x.toJson())),
    "notification_banner": notificationBanner == null ? null : List<dynamic>.from(notificationBanner.map((x) => x.toJson())),
  };
}

class NotificationBanner {
  NotificationBanner({
    this.id,
    this.name,
    this.url,
    this.upProImg,
  });

  String id;
  String name;
  String url;
  String upProImg;

  factory NotificationBanner.fromJson(Map<String, dynamic> json) => NotificationBanner(
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

class NotificationList {
  NotificationList({
    this.id,
    this.name,
    this.description,
    this.date,
  });

  String id;
  String name;
  String description;
  String date;

  factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    date: json["date"] == null ? null :json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "date": date == null ? null : date,
  };
}
