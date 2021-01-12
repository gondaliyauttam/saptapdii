// To parse this JSON data, do
//
//     final inspirationDetailData = inspirationDetailDataFromJson(jsonString);

import 'dart:convert';

import 'package:saptapadi/model/vender_catagory.dart';

InspirationDetailData inspirationDetailDataFromJson(String str) => InspirationDetailData.fromJson(json.decode(str));


class InspirationDetailData {
  InspirationDetailData({
    this.groomBrideName,
    this.weddingDate,
    this.description,
    this.upProImg,
    this.statusCode,
    this.msg,
    this.vendergallery,
    this.vendorCredit,
  });

  String groomBrideName;
  String weddingDate;
  String description;
  String upProImg;
  int statusCode;
  String msg;
  List<VendorGallery> vendergallery;
  List<VendorCredit> vendorCredit;

  factory InspirationDetailData.fromJson(Map<String, dynamic> json) => InspirationDetailData(
    groomBrideName: json["groom_bride_name"] == null ? null : json["groom_bride_name"],
    weddingDate: json["wedding_date"] == null ? null : json["wedding_date"],
    description: json["description"] == null ? null : json["description"],
    upProImg: json["up_pro_img"] == null ? null : json["up_pro_img"],
    statusCode: json["status_code"] == null ? null : json["status_code"],
    msg: json["msg"] == null ? null : json["msg"],
    vendergallery: json["inspiration_gallery"] == null ? null : List<VendorGallery>.from(json["inspiration_gallery"].map((x) => VendorGallery.fromJson(x))),
    vendorCredit: json["vendor_credit"] == null ? null : List<VendorCredit>.from(json["vendor_credit"].map((x) => VendorCredit.fromJson(x))),
  );

}

class VendorCredit {
  VendorCredit({
    this.vid,
    this.category,
    this.name,
    this.address,
    this.upProImg,
  });

  String vid;
  String category;
  String name;
  String address;
  String upProImg;

  factory VendorCredit.fromJson(Map<String, dynamic> json) => VendorCredit(
    vid: json["vid"] == null ? null : json["vid"],
    category: json["category"] == null ? null : json["category"],
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    upProImg: json["up_pro_img"] == null ? null : json["up_pro_img"],
  );

  Map<String, dynamic> toJson() => {
    "vid": vid == null ? null : vid,
    "category": category == null ? null : category,
    "name": name == null ? null : name,
    "address": address == null ? null : address,
    "up_pro_img": upProImg == null ? null : upProImg,
  };
}
