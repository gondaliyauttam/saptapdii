// To parse this JSON data, do
//
//     final notificationDetailsData = notificationDetailsDataFromJson(jsonString);

import 'dart:convert';

NotificationDetailsData notificationDetailsDataFromJson(String str) => NotificationDetailsData.fromJson(json.decode(str));

String notificationDetailsDataToJson(NotificationDetailsData data) => json.encode(data.toJson());

class NotificationDetailsData {
  NotificationDetailsData({
    this.statusCode,
    this.msg,
    this.notificationList,
    this.notificationBanner,
  });

  int statusCode;
  String msg;
  List<Notification> notificationList;
  Notification notificationBanner;

  factory NotificationDetailsData.fromJson(Map<String, dynamic> json) => NotificationDetailsData(
    statusCode: json["status_code"] == null ? null : json["status_code"],
    msg: json["msg"] == null ? null : json["msg"],
    notificationList: json["notification_list"] == null ? null : List<Notification>.from(json["notification_list"].map((x) => Notification.fromJson(x))),
    notificationBanner: json["notification_banner"] == null ? null : Notification.fromJson(json["notification_banner"]),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode == null ? null : statusCode,
    "msg": msg == null ? null : msg,
    "notification_list": notificationList == null ? null : List<dynamic>.from(notificationList.map((x) => x.toJson())),
    "notification_banner": notificationBanner == null ? null : notificationBanner.toJson(),
  };
}

class Notification {
  Notification({
    this.id,
    this.name,
    this.url,
    this.upProImg,
    this.description,
  });

  String id;
  String name;
  String url;
  String upProImg;
  String description;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    url: json["url"] == null ? null : json["url"],
    upProImg: json["up_pro_img"] == null ? null : json["up_pro_img"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "url": url == null ? null : url,
    "up_pro_img": upProImg == null ? null : upProImg,
    "description": description == null ? null : description,
  };
}
