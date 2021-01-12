// To parse this JSON data, do
//
//     final discountData = discountDataFromJson(jsonString);

import 'dart:convert';

DiscountData discountDataFromJson(String str) =>
    DiscountData.fromJson(json.decode(str));

String discountDataToJson(DiscountData data) => json.encode(data.toJson());

class DiscountData {
  DiscountData({
    this.statusCode,
    this.msg,
    this.sponserList,
    this.discountList,
  });

  int statusCode;
  String msg;
  List<DiscountList> sponserList;
  List<DiscountList> discountList;

  factory DiscountData.fromJson(Map<String, dynamic> json) => DiscountData(
        statusCode: json["status_code"] == null ? null : json["status_code"],
        msg: json["msg"] == null ? null : json["msg"],
        sponserList: json["sponser_list"] == null
            ? null
            : List<DiscountList>.from(
                json["sponser_list"].map((x) => DiscountList.fromJson(x))),
        discountList: json["discount_list"] == null
            ? null
            : List<DiscountList>.from(
                json["discount_list"].map((x) => DiscountList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode == null ? null : statusCode,
        "msg": msg == null ? null : msg,
        "sponser_list": sponserList == null
            ? null
            : List<dynamic>.from(sponserList.map((x) => x.toJson())),
        "discount_list": discountList == null
            ? null
            : List<dynamic>.from(discountList.map((x) => x.toJson())),
      };
}

class DiscountList {
  DiscountList({
    this.id,
    this.vendorCategory,
    this.vendorName,
    this.vendorAddress,
    this.discount,
    this.description,
    this.sponser,
    this.upProImg,
  });

  String id;
  String vendorCategory;
  String vendorName;
  String vendorAddress;
  String discount;
  String description;
  String sponser;
  String upProImg;

  factory DiscountList.fromJson(Map<String, dynamic> json) => DiscountList(
        id: json["id"] == null ? null : json["id"],
        vendorCategory:
            json["vendor_category"] == null ? null : json["vendor_category"],
        vendorName: json["vendor_name"] == null ? null : json["vendor_name"],
        vendorAddress:
            json["vendor_address"] == null ? null : json["vendor_address"],
        discount: json["discount"] == null ? null : json["discount"],
        description: json["description"] == null ? null : json["description"],
        sponser: json["sponser"] == null ? null : json["sponser"],
        upProImg: json["up_pro_img"] == null ? null : json["up_pro_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "vendor_category": vendorCategory == null ? null : vendorCategory,
        "vendor_name": vendorName == null ? null : vendorName,
        "vendor_address": vendorAddress == null ? null : vendorAddress,
        "discount": discount == null ? null : discount,
        "description": description == null ? null : description,
        "sponser": sponser == null ? null : sponser,
        "up_pro_img": upProImg == null ? null : upProImg,
      };
}
