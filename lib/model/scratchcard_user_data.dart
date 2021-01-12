// To parse this JSON data, do
//
//     final scratchCardUserData = scratchCardUserDataFromJson(jsonString);

import 'dart:convert';

ScratchCardUserData scratchCardUserDataFromJson(String str) => ScratchCardUserData.fromJson(json.decode(str));

String scratchCardUserDataToJson(ScratchCardUserData data) => json.encode(data.toJson());

class ScratchCardUserData {
  ScratchCardUserData({
    this.statusCode,
    this.msg,
    this.scratchCard,
  });

  int statusCode;
  String msg;
  List<ScratchCard> scratchCard;

  factory ScratchCardUserData.fromJson(Map<String, dynamic> json) => ScratchCardUserData(
    statusCode: json["status_code"] == null ? null : json["status_code"],
    msg: json["msg"] == null ? null : json["msg"],
    scratchCard: json["scratch_card"] == null ? null : List<ScratchCard>.from(json["scratch_card"].map((x) => ScratchCard.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode == null ? null : statusCode,
    "msg": msg == null ? null : msg,
    "scratch_card": scratchCard == null ? null : List<dynamic>.from(scratchCard.map((x) => x.toJson())),
  };
}

class ScratchCard {
  ScratchCard({
    this.id,
    this.scratchCardId,
    this.scratchCard,
    this.vendorName,
    this.vendorAddress,
    this.vendorMobile,
    this.upProImg,
    this.redeem,
  });

  String id;
  String scratchCardId;
  String scratchCard;
  String vendorName;
  String vendorAddress;
  String vendorMobile;
  String upProImg;
  String redeem;

  factory ScratchCard.fromJson(Map<String, dynamic> json) => ScratchCard(
    id: json["id"] == null ? null : json["id"],
    scratchCardId: json["scratch_card_id"] == null ? null : json["scratch_card_id"],
    scratchCard: json["scratch_card"] == null ? null : json["scratch_card"],
    vendorName: json["vendor_name"] == null ? null : json["vendor_name"],
    vendorAddress: json["vendor_address"] == null ? null : json["vendor_address"],
    vendorMobile: json["vendor_mobile"] == null ? null : json["vendor_mobile"],
    upProImg: json["up_pro_img"] == null ? null : json["up_pro_img"],
    redeem: json["redeem"] == null ? null : json["redeem"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "scratch_card_id": scratchCardId == null ? null : scratchCardId,
    "scratch_card": scratchCard == null ? null : scratchCard,
    "vendor_name": vendorName == null ? null : vendorName,
    "vendor_address": vendorAddress == null ? null : vendorAddress,
    "vendor_mobile": vendorMobile == null ? null : vendorMobile,
    "up_pro_img": upProImg == null ? null : upProImg,
    "redeem": redeem == null ? null : redeem,
  };
}
