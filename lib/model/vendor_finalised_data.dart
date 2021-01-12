// To parse this JSON data, do
//
//     final vendorSortListData = vendorSortListDataFromJson(jsonString);

import 'dart:convert';

import 'package:saptapadi/model/vendor_shortlist_data.dart';

VendorFinalisedData vendorFinalisedDataFromJson(String str) => VendorFinalisedData.fromJson(json.decode(str));


class VendorFinalisedData {
  VendorFinalisedData({
    this.statusCode,
    this.msg,
    this.vendorsShortlist,
  });

  int statusCode;
  String msg;
  List<VendorsShortlist> vendorsShortlist;

  factory VendorFinalisedData.fromJson(Map<String, dynamic> json) => VendorFinalisedData(
    statusCode: json["status_code"] == null ? null : json["status_code"],
    msg: json["msg"] == null ? null : json["msg"],
    vendorsShortlist: json["vendors_finalised"] == null ? null : List<VendorsShortlist>.from(json["vendors_finalised"].map((x) => VendorsShortlist.fromJson(x))),
  );

}

