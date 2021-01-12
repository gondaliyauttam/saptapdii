// To parse this JSON data, do
//
//     final favouriteData = favouriteDataFromJson(jsonString);

import 'dart:convert';

FavouriteData favouriteDataFromJson(String str) => FavouriteData.fromJson(json.decode(str));

String favouriteDataToJson(FavouriteData data) => json.encode(data.toJson());

class FavouriteData {
  FavouriteData({
    this.statusCode,
    this.msg,
    this.favourites,
  });

  int statusCode;
  String msg;
  List<Favourite> favourites;

  factory FavouriteData.fromJson(Map<String, dynamic> json) => FavouriteData(
    statusCode: json["status_code"] == null ? null : json["status_code"],
    msg: json["msg"] == null ? null : json["msg"],
    favourites: json["favourites"] == null ? null : List<Favourite>.from(json["favourites"].map((x) => Favourite.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode == null ? null : statusCode,
    "msg": msg == null ? null : msg,
    "favourites": favourites == null ? null : List<dynamic>.from(favourites.map((x) => x.toJson())),
  };
}

class Favourite {
  Favourite({
    this.id,
    this.category,
    this.name,
    this.description,
    this.upProImg,
  });

  String id;
  String category;
  String name;
  String description;
  String upProImg;

  factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
    id: json["id"] == null ? null : json["id"],
    category: json["category"] == null ? null : json["category"],
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    upProImg: json["up_pro_img"] == null ? null : json["up_pro_img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "category": category == null ? null : category,
    "name": name == null ? null : name,
    "description": description == null ? null : description,
    "up_pro_img": upProImg == null ? null : upProImg,
  };
}
