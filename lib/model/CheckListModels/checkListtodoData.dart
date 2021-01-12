// To parse this JSON data, do
//
//     final checkListData = checkListDataFromJson(jsonString);

import 'dart:convert';

CheckListTodoData checkListTodoDataFromJson(String str) => CheckListTodoData.fromJson(json.decode(str));

String checkListTodoDataToJson(CheckListTodoData data) => json.encode(data.toJson());

class CheckListTodoData {
  CheckListTodoData({
    this.statusCode,
    this.msg,
    this.checkList,
  });

  int statusCode;
  String msg;
  List<CheckList> checkList;

  factory CheckListTodoData.fromJson(Map<String, dynamic> json) => CheckListTodoData(
    statusCode: json["status_code"] == null ? null : json["status_code"],
    msg: json["msg"] == null ? null : json["msg"],
    checkList: json["check_list"] == null ? null : List<CheckList>.from(json["check_list"].map((x) => CheckList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode == null ? null : statusCode,
    "msg": msg == null ? null : msg,
    "check_list": checkList == null ? null : List<dynamic>.from(checkList.map((x) => x.toJson())),
  };
}

class CheckList {
  CheckList({
    this.id,
    this.name,
    this.checklistDone,
    this.checklistId,
  });

  String id;
  String name;
  String checklistDone;
  String checklistId;

  factory CheckList.fromJson(Map<String, dynamic> json) => CheckList(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    checklistDone: json["checklist_done"] == null ? null : json["checklist_done"],
    checklistId: json["checklist_id"] == null ? null : json["checklist_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "checklist_done": checklistDone == null ? null : checklistDone,
  };
}
