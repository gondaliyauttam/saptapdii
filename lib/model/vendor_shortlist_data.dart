// To parse this JSON data, do
//
//     final vendorSortListData = vendorSortListDataFromJson(jsonString);

import 'dart:convert';

VendorSortListData vendorSortListDataFromJson(String str) => VendorSortListData.fromJson(json.decode(str));

String vendorSortListDataToJson(VendorSortListData data) => json.encode(data.toJson());

class VendorSortListData {
  VendorSortListData({
    this.statusCode,
    this.msg,
    this.vendorsShortlist,
  });

  int statusCode;
  String msg;
  List<VendorsShortlist> vendorsShortlist;

  factory VendorSortListData.fromJson(Map<String, dynamic> json) => VendorSortListData(
    statusCode: json["status_code"] == null ? null : json["status_code"],
    msg: json["msg"] == null ? null : json["msg"],
    vendorsShortlist: json["vendors_shortlist"] == null ? null : List<VendorsShortlist>.from(json["vendors_shortlist"].map((x) => VendorsShortlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode == null ? null : statusCode,
    "msg": msg == null ? null : msg,
    "vendors_shortlist": vendorsShortlist == null ? null : List<dynamic>.from(vendorsShortlist.map((x) => x.toJson())),
  };
}

class VendorsShortlist {
  VendorsShortlist({
    this.id,
    this.vid,
    this.name,
    this.address,
    this.contactNo,
    this.whatsappMobile,
    this.upProImg,
    this.userMobile,
  });

  String id;
  String vid;
  String name;
  String address;
  String contactNo;
  String whatsappMobile;
  String upProImg;
  String userMobile;

  factory VendorsShortlist.fromJson(Map<String, dynamic> json) => VendorsShortlist(
    id: json["id"] == null ? null : json["id"],
    vid: json["vid"] == null ? null : json["vid"],
    name: json["name"] == null ? null : json["name"],
    address: json["address"] == null ? null : json["address"],
    contactNo: json["contact_no"] == null ? null : json["contact_no"],
    whatsappMobile: json["whatsapp_mobile"] == null ? null : json["whatsapp_mobile"],
    upProImg: json["up_pro_img"] == null ? null : json["up_pro_img"],
    userMobile: json["user_mobile"] == null ? null : json["user_mobile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "vid": vid == null ? null : vid,
    "name": name == null ? null : name,
    "address": address == null ? null : address,
    "contact_no": contactNo == null ? null : contactNo,
    "whatsapp_mobile": whatsappMobile == null ? null : whatsappMobile,
    "up_pro_img": upProImg == null ? null : upProImg,
    "user_mobile": userMobile == null ? null : userMobile,
  };
}
