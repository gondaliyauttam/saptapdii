import 'dart:convert';

HomeScreenBanner homeScreenBannerFromJson(String str) =>
    HomeScreenBanner.fromJson(json.decode(str));

String homeScreenBannerToJson(HomeScreenBanner data) =>
    json.encode(data.toJson());

class HomeScreenBanner {
  HomeScreenBanner({
    this.statusCode,
    this.msg,
    this.bannerStatus,
    this.bannerMsg,
    this.homeScreenBanner,
    this.registerScreenBanner,
  });

  int statusCode;
  String msg;
  int bannerStatus;
  String bannerMsg;
  List<ScreenBanner> homeScreenBanner;
  ScreenBanner registerScreenBanner;

  factory HomeScreenBanner.fromJson(Map<String, dynamic> json) =>
      HomeScreenBanner(
        statusCode: json["status_code"],
        msg: json["msg"],
        bannerStatus: json["banner_status"],
        bannerMsg: json["banner_msg"],
        homeScreenBanner: List<ScreenBanner>.from(
            json["home_screen_banner"].map((x) => ScreenBanner.fromJson(x))),
        registerScreenBanner:
            ScreenBanner.fromJson(json["register_screen_banner"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "msg": msg,
        "banner_status": bannerStatus,
        "banner_msg": bannerMsg,
        "home_screen_banner":
            List<dynamic>.from(homeScreenBanner.map((x) => x.toJson())),
        "register_screen_banner": registerScreenBanner.toJson(),
      };
}

class ScreenBanner {
  ScreenBanner({
    this.id,
    this.name,
    this.url,
    this.upProImg,
    this.colorCode,
  });

  String id;
  String name;
  String url;
  String upProImg;
  String colorCode;

  factory ScreenBanner.fromJson(Map<String, dynamic> json) => ScreenBanner(
        id: json["id"],
        name: json["name"],
        url: json["url"] == null ? null : json["url"],
        upProImg: json["up_pro_img"],
        colorCode: json["color_code"] == null ? null : json["color_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url == null ? null : url,
        "up_pro_img": upProImg,
        "color_code": colorCode == null ? null : colorCode,
      };
}
