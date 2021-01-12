// To parse this JSON data, do
//
//     final weddingProfile = weddingProfileFromJson(jsonString);

import 'dart:convert';

WeddingProfile weddingProfileFromJson(String str) =>
    WeddingProfile.fromJson(json.decode(str));

class WeddingProfile {
  WeddingProfile({
    this.statusCode,
    this.msg,
    this.notificationCount,
    this.weddingProfile,
    this.myChecklist,
    this.myShortlist,
    this.weddingProfileBanner,
    this.settings,
  });

  int statusCode;
  String msg;
  NotificationCount notificationCount;
  WeddingProfileClass weddingProfile;
  MyChecklist myChecklist;
  MyShortlist myShortlist;
  WeddingProfileBanner weddingProfileBanner;
  Settings settings;

  factory WeddingProfile.fromJson(Map<String, dynamic> json) => WeddingProfile(
        statusCode: json["status_code"] == null ? null : json["status_code"],
        msg: json["msg"] == null ? null : json["msg"],
        notificationCount: json["notification_count"] == null
            ? null
            : NotificationCount.fromJson(json["notification_count"]),
        weddingProfile: json["wedding_profile"] == null
            ? null
            : WeddingProfileClass.fromJson(json["wedding_profile"]),
        myChecklist: json["my_checklist"] == null
            ? null
            : MyChecklist.fromJson(json["my_checklist"]),
        myShortlist: json["my_shortlist"] == null
            ? null
            : MyShortlist.fromJson(json["my_shortlist"]),
        weddingProfileBanner: json["wedding_profile_banner"] == null
            ? null
            : WeddingProfileBanner.fromJson(json["wedding_profile_banner"]),
        settings: json["settings"] == null
            ? null
            : Settings.fromJson(json["settings"]),
      );
}

class MyChecklist {
  MyChecklist({
    this.totalChecklist,
    this.doneChecklist,
  });

  int totalChecklist;
  int doneChecklist;

  factory MyChecklist.fromJson(Map<String, dynamic> json) => MyChecklist(
        totalChecklist:
            json["total_checklist"] == null ? null : json["total_checklist"],
        doneChecklist:
            json["done_checklist"] == null ? null : json["done_checklist"],
      );

  Map<String, dynamic> toJson() => {
        "total_checklist": totalChecklist == null ? null : totalChecklist,
        "done_checklist": doneChecklist == null ? null : doneChecklist,
      };
}

class MyShortlist {
  MyShortlist({
    this.totalShortlist,
    this.totalFinalised,
  });

  int totalShortlist;
  int totalFinalised;

  factory MyShortlist.fromJson(Map<String, dynamic> json) => MyShortlist(
        totalShortlist:
            json["total_shortlist"] == null ? null : json["total_shortlist"],
        totalFinalised:
            json["total_finalised"] == null ? null : json["total_finalised"],
      );

  Map<String, dynamic> toJson() => {
        "total_shortlist": totalShortlist == null ? null : totalShortlist,
        "total_finalised": totalFinalised == null ? null : totalFinalised,
      };
}

class NotificationCount {
  NotificationCount({
    this.count,
  });

  String count;

  factory NotificationCount.fromJson(Map<String, dynamic> json) =>
      NotificationCount(
        count: json["count"] == null ? null : json["count"],
      );

  Map<String, dynamic> toJson() => {
        "count": count == null ? null : count,
      };
}

class Settings {
  Settings({
    this.iosVersion,
    this.isfourceupdate,
    this.updateMsg,
    this.appshareMsg,
    this.newspostSharemsg,
  });

  String iosVersion;
  String isfourceupdate;
  String updateMsg;
  String appshareMsg;
  String newspostSharemsg;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        iosVersion: json["ios_version"] == null ? null : json["ios_version"],
        isfourceupdate:
            json["isfourceupdate"] == null ? null : json["isfourceupdate"],
        updateMsg: json["update_msg"] == null ? null : json["update_msg"],
        appshareMsg: json["appshare_msg"] == null ? null : json["appshare_msg"],
        newspostSharemsg: json["newspost_sharemsg"] == null
            ? null
            : json["newspost_sharemsg"],
      );

  Map<String, dynamic> toJson() => {
        "ios_version": iosVersion == null ? null : iosVersion,
        "isfourceupdate": isfourceupdate == null ? null : isfourceupdate,
        "update_msg": updateMsg == null ? null : updateMsg,
        "appshare_msg": appshareMsg == null ? null : appshareMsg,
        "newspost_sharemsg": newspostSharemsg == null ? null : newspostSharemsg,
      };
}

class WeddingProfileClass {
  WeddingProfileClass({
    this.id,
    this.userMobile,
    this.groomName,
    this.brideName,
    this.weddingDate,
    this.city,
    this.mobile,
    this.upProImg,
  });

  String id;
  String userMobile;
  String groomName;
  String brideName;
  String weddingDate;
  String city;
  String mobile;
  String upProImg;

  factory WeddingProfileClass.fromJson(Map<String, dynamic> json) =>
      WeddingProfileClass(
        id: json["id"] == null ? null : json["id"],
        userMobile: json["user_mobile"] == null ? null : json["user_mobile"],
        groomName: json["groom_name"] == null ? null : json["groom_name"] == ""?"Groom Name": json["groom_name"],
        brideName: json["bride_name"] == null ? null : json["bride_name"],
        weddingDate: json["wedding_date"] == null ? null : json["wedding_date"],
        city: json["city"] == null ? null : json["city"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        upProImg: json["up_pro_img"] == null ? null : json["up_pro_img"],
      );

  Map<String, dynamic> toProfileDataJson() => {
        "id": id,
        "user_mobile": userMobile,
        "groom_name": groomName,
        "bride_name": brideName,
        "wedding_date": weddingDate,
        "city": city,
        "mobile": mobile,
        "up_pro_img": upProImg,
      };
}

class WeddingProfileBanner {
  WeddingProfileBanner({
    this.id,
    this.name,
    this.url,
    this.upProImg,
  });

  String id;
  String name;
  String url;
  String upProImg;

  factory WeddingProfileBanner.fromJson(Map<String, dynamic> json) =>
      WeddingProfileBanner(
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
