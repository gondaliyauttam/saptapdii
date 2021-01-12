// To parse this JSON data, do
//
//     final inspirationData = inspirationDataFromJson(jsonString);

import 'dart:convert';

InspirationData inspirationDataFromJson(String str) => InspirationData.fromJson(json.decode(str));


class InspirationData {
  InspirationData({
    this.statusCode,
    this.msg,
    this.inspiration,
  });

  int statusCode;
  String msg;
  List<Inspiration> inspiration;

  factory InspirationData.fromJson(Map<String, dynamic> json) => InspirationData(
    statusCode: json["status_code"] == null ? null : json["status_code"],
    msg: json["msg"] == null ? null : json["msg"],
    inspiration: json["inspiration"] == null ? null : List<Inspiration>.from(json["inspiration"].map((x) => Inspiration.fromJson(x))),
  );

}

class Inspiration {
  Inspiration({
    this.id,
    this.groomBrideName,
    this.weddingDate,
    this.description,
    this.upProImg,
  });

  String id;
  String groomBrideName;
  String weddingDate;
  String description;
  String upProImg;

  factory Inspiration.fromJson(Map<String, dynamic> json) => Inspiration(
    id: json["id"] == null ? null : json["id"],
    groomBrideName: json["groom_bride_name"] == null ? null : json["groom_bride_name"],
    weddingDate: json["wedding_date"] == null ? null : json["wedding_date"],
    description: json["description"] == null ? null : json["description"],
    upProImg: json["up_pro_img"] == null ? null : json["up_pro_img"],
  );

}
