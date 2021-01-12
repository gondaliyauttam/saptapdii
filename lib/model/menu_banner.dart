import 'dart:convert';

Menubanner menubannerFromJson(String str) =>
    Menubanner.fromJson(json.decode(str));

String menubannerToJson(Menubanner data) => json.encode(data.toJson());

class Menubanner {
  Menubanner({
    this.statusCode,
    this.msg,
    this.menuScreenBanner,
  });

  int statusCode;
  String msg;
  MenuScreenBanner menuScreenBanner;

  factory Menubanner.fromJson(Map<String, dynamic> json) => Menubanner(
        statusCode: json["status_code"],
        msg: json["msg"],
        menuScreenBanner: MenuScreenBanner.fromJson(json["menu_screen_banner"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "msg": msg,
        "menu_screen_banner": menuScreenBanner.toJson(),
      };
}

class MenuScreenBanner {
  MenuScreenBanner({
    this.id,
    this.name,
    this.url,
    this.colorCode,
    this.upProImg,
  });

  String id;
  String name;
  String url;
  String colorCode;
  String upProImg;

  factory MenuScreenBanner.fromJson(Map<String, dynamic> json) =>
      MenuScreenBanner(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        colorCode: json["color_code"],
        upProImg: json["up_pro_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "color_code": colorCode,
        "up_pro_img": upProImg,
      };
}
