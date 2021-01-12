import 'dart:convert';

Registermodel registermodelFromJson(String str) =>
    Registermodel.fromJson(json.decode(str));

String registermodelToJson(Registermodel data) => json.encode(data.toJson());

class Registermodel {
  Registermodel({
    this.statusCode,
    this.msg,
    this.city,
    this.mobile,
    this.name,
  });

  int statusCode;
  String msg;
  String name;
  String mobile;
  String city;

  factory Registermodel.fromJson(Map<String, dynamic> json) => Registermodel(
        statusCode: json["status_code"],
        msg: json["msg"],
        city: json["city"],
        mobile: json["mobile"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "mobile": mobile,
        "city": city,
      };
}
