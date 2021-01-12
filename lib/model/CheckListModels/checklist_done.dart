// To parse this JSON data, do
//
//     final checkListDoneData = checkListDoneDataFromJson(jsonString);

import 'dart:convert';

CheckListDoneData checkListDoneDataFromJson(String str) => CheckListDoneData.fromJson(json.decode(str));

String checkListDoneDataToJson(CheckListDoneData data) => json.encode(data.toJson());

class CheckListDoneData {
  CheckListDoneData({
    this.statusCode,
    this.msg,
    this.checklistDone,
  });

  int statusCode;
  String msg;
  List<ChecklistDone> checklistDone;

  factory CheckListDoneData.fromJson(Map<String, dynamic> json) => CheckListDoneData(
    statusCode: json["status_code"] == null ? null : json["status_code"],
    msg: json["msg"] == null ? null : json["msg"],
    checklistDone: json["checklist_done"] == null ? null : List<ChecklistDone>.from(json["checklist_done"].map((x) => ChecklistDone.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode == null ? null : statusCode,
    "msg": msg == null ? null : msg,
    "checklist_done": checklistDone == null ? null : List<dynamic>.from(checklistDone.map((x) => x.toJson())),
  };
}

class ChecklistDone {
  ChecklistDone({
    this.id,
    this.checklistId,
    this.name,
    this.userMobile,
  });

  String id;
  String checklistId;
  String name;
  String userMobile;

  factory ChecklistDone.fromJson(Map<String, dynamic> json) => ChecklistDone(
    id: json["id"] == null ? null : json["id"],
    checklistId: json["checklist_id"] == null ? null : json["checklist_id"],
    name: json["name"] == null ? null : json["name"],
    userMobile: json["user_mobile"] == null ? null : json["user_mobile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "checklist_id": checklistId == null ? null : checklistId,
    "name": name == null ? null : name,
    "user_mobile": userMobile == null ? null : userMobile,
  };
}
