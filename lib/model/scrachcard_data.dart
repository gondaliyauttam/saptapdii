

import 'dart:convert';

ScarchCardData scarchCardDataFromJson(String str) => ScarchCardData.fromJson(json.decode(str));

String scarchCardDataToJson(ScarchCardData data) => json.encode(data.toJson());

class ScarchCardData {
  ScarchCardData({
    this.scratchCardId,
    this.scratchCard,
    this.statusCode,
    this.msg,
    this.scratchCardBanner,
  });

  String scratchCardId;
  String scratchCard;
  int statusCode;
  String msg;
  ScratchCardBanner scratchCardBanner;

  factory ScarchCardData.fromJson(Map<String, dynamic> json) => ScarchCardData(
    scratchCardId: json["scratch_card_id"] == null ? null : json["scratch_card_id"],
    scratchCard: json["scratch_card"] == null ? null : json["scratch_card"],
    statusCode: json["status_code"] == null ? null : json["status_code"],
    msg: json["msg"] == null ? null : json["msg"],
    scratchCardBanner: json["scratch_card_banner"] == null ? null : ScratchCardBanner.fromJson(json["scratch_card_banner"]),
  );

  Map<String, dynamic> toJson() => {
    "scratch_card_id": scratchCardId == null ? null : scratchCardId,
    "scratch_card": scratchCard == null ? null : scratchCard,
    "status_code": statusCode == null ? null : statusCode,
    "msg": msg == null ? null : msg,
    "scratch_card_banner": scratchCardBanner == null ? null : scratchCardBanner.toJson(),
  };
}

class ScratchCardBanner {
  ScratchCardBanner({
    this.id,
    this.name,
    this.url,
    this.upProImg,
  });

  String id;
  String name;
  String url;
  String upProImg;

  factory ScratchCardBanner.fromJson(Map<String, dynamic> json) => ScratchCardBanner(
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

