// To parse this JSON data, do
//
//     final termCondition = termConditionFromJson(jsonString);

import 'dart:convert';

TermCondition termConditionFromJson(String str) =>
    TermCondition.fromJson(json.decode(str));

String termConditionToJson(TermCondition data) => json.encode(data.toJson());
TermConditions termConditionsFromJson(String str) =>
    TermConditions.fromJson(json.decode(str));

String termConditionsToJson(TermCondition data) => json.encode(data.toJson());

class TermCondition {
  TermCondition({
    this.statusCode,
    this.msg,
    this.aboutUs,
    this.terms,
    this.email,
    this.message,
    this.mobile,
    this.name,
    this.type,
  });

  int statusCode;
  String msg;
  AboutUs aboutUs;
  Terms terms;
  String name;
  String email;
  String mobile;
  String type;
  String message;

  factory TermCondition.fromJson(Map<String, dynamic> json) => TermCondition(
        statusCode: json["status_code"],
        msg: json["msg"],
        // aboutUs: AboutUs.fromJson(json["about_us"]),
        // terms: Terms.fromJson(json["terms"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "mobile": mobile,
        "type": type,
        "message": message,
      };
}

class TermConditions {
  TermConditions({
    this.aboutUs,
    this.terms,
  });

  int statusCode;

  AboutUs aboutUs;
  Terms terms;

  factory TermConditions.fromJson(Map<String, dynamic> json) => TermConditions(
        aboutUs: AboutUs.fromJson(json["about_us"]),
        terms: Terms.fromJson(json["terms"]),
      );
}

class AboutUs {
  AboutUs({
    this.name,
    this.description,
  });

  String name;
  String description;

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
        name: json["name"],
        description: json["description"],
      );
}

class Terms {
  Terms({
    this.id,
    this.name,
    this.description,
  });

  String id;
  String name;
  String description;

  factory Terms.fromJson(Map<String, dynamic> json) => Terms(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );
}
