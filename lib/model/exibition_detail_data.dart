// To parse this JSON data, do
//
//     final exhibitionDetailData = exhibitionDetailDataFromJson(jsonString);

import 'dart:convert';

ExhibitionDetailData exhibitionDetailDataFromJson(String str) => ExhibitionDetailData.fromJson(json.decode(str));


class ExhibitionDetailData {
  ExhibitionDetailData({
    this.statusCode,
    this.msg,
    this.exhibitionList,
    this.exhibitionGallery,
    this.exhibitionBanner,
  });

  int statusCode;
  String msg;
  ExhibitionList exhibitionList;
  dynamic exhibitionGallery;
  ExhibitionBanner exhibitionBanner;

  factory ExhibitionDetailData.fromJson(Map<String, dynamic> json) => ExhibitionDetailData(
    statusCode: json["status_code"] == null ? null : json["status_code"],
    msg: json["msg"] == null ? null : json["msg"],
    exhibitionList: json["exhibition_list"] == null ? null : ExhibitionList.fromJson(json["exhibition_list"]),
    exhibitionGallery: json["exhibition_gallery"],
    exhibitionBanner: json["exhibition_banner"] == null ? null : ExhibitionBanner.fromJson(json["exhibition_banner"]),
  );

}

class ExhibitionBanner {
  ExhibitionBanner({
    this.id,
    this.name,
    this.url,
    this.upProImg,
  });

  String id;
  String name;
  String url;
  String upProImg;

  factory ExhibitionBanner.fromJson(Map<String, dynamic> json) => ExhibitionBanner(
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

class ExhibitionList {
  ExhibitionList({
    this.id,
    this.name,
    this.address,
    this.exhibitionDate,
    this.entryPassImg,
    this.upProImg,
    this.description,
  });

  String id;
  String name;
  String address;
  String exhibitionDate;
  String entryPassImg;
  String upProImg;
  String description;

  factory ExhibitionList.fromJson(Map<String, dynamic> json) => ExhibitionList(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    exhibitionDate: json["exhibition_date"] == null ? null : json["exhibition_date"],
    entryPassImg: json["entry_pass_img"] == null ? null : json["entry_pass_img"],
    upProImg: json["up_pro_img"] == null ? null : json["up_pro_img"],
    description: json["description"] == null ? null : json["description"],
  );

}
