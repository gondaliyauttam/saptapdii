// To parse this JSON data, do
//
//     final exhibitionData = exhibitionDataFromJson(jsonString);

import 'dart:convert';

ExhibitionData exhibitionDataFromJson(String str) => ExhibitionData.fromJson(json.decode(str));


class ExhibitionData {
  ExhibitionData({
    this.statusCode,
    this.msg,
    this.exhibitionList,
  });

  int statusCode;
  String msg;
  List<ExhibitionList> exhibitionList;

  factory ExhibitionData.fromJson(Map<String, dynamic> json) => ExhibitionData(
    statusCode: json["status_code"] == null ? null : json["status_code"],
    msg: json["msg"] == null ? null : json["msg"],
    exhibitionList: json["exhibition_list"] == null ? null : List<ExhibitionList>.from(json["exhibition_list"].map((x) => ExhibitionList.fromJson(x))),
  );

}

class ExhibitionList {
  ExhibitionList({
    this.id,
    this.name,
    this.address,
    this.exhibitionDate,
    this.upProImg,
  });

  String id;
  String name;
  String address;
  String exhibitionDate;
  String upProImg;

  factory ExhibitionList.fromJson(Map<String, dynamic> json) => ExhibitionList(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    exhibitionDate: json["exhibition_date"] == null ? null :json["exhibition_date"],
    upProImg: json["up_pro_img"] == null ? null : json["up_pro_img"],
  );

}
