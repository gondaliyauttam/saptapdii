// To parse this JSON data, do
//
//     final trendingNews = trendingNewsFromJson(jsonString);

import 'dart:convert';

TrendingNews trendingNewsFromJson(String str) =>
    TrendingNews.fromJson(json.decode(str));

String trendingNewsToJson(TrendingNews data) => json.encode(data.toJson());

class TrendingNews {
  TrendingNews({
    this.statusCode,
    this.msg,
    this.trendingNews,
    this.trendingNewsBanner,
  });

  int statusCode;
  String msg;
  List<TrendingNew> trendingNews;
  List<TrendingNewsBanner> trendingNewsBanner;

  factory TrendingNews.fromJson(Map<String, dynamic> json) => TrendingNews(
        statusCode: json["status_code"],
        msg: json["msg"],
        trendingNews: List<TrendingNew>.from(
            json["trending_news"].map((x) => TrendingNew.fromJson(x))),
        trendingNewsBanner: List<TrendingNewsBanner>.from(
            json["trending_news_banner"]
                .map((x) => TrendingNewsBanner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "msg": msg,
        "trending_news":
            List<dynamic>.from(trendingNews.map((x) => x.toJson())),
        "trending_news_banner":
            List<dynamic>.from(trendingNewsBanner.map((x) => x.toJson())),
      };
}

class TrendingNew {
  TrendingNew({
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
  TrendingNewsBanner trendingNewsBanner;

  factory TrendingNew.fromJson(Map<String, dynamic> json) => TrendingNew(
        id: json["id"],
        category: json["category"],
        name: json["name"],
        description: json["description"],
        upProImg: json["up_pro_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "name": name,
        "description": description,
        "up_pro_img": upProImg,
      };
}

class TrendingNewsBanner {
  TrendingNewsBanner({
    this.id,
    this.name,
    this.url,
    this.upProImg,
  });

  String id;
  String name;
  String url;
  String upProImg;

  factory TrendingNewsBanner.fromJson(Map<String, dynamic> json) =>
      TrendingNewsBanner(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        upProImg: json["up_pro_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "up_pro_img": upProImg,
      };
}

// To parse this JSON data, do
//
//     final trendingdetail = trendingdetailFromJson(jsonString);

Trendingdetail trendingdetailFromJson(String str) =>
    Trendingdetail.fromJson(json.decode(str));

String trendingdetailToJson(Trendingdetail data) => json.encode(data.toJson());

class Trendingdetail {
  Trendingdetail({
    this.statusCode,
    this.msg,
    this.trendingNewsDetail,
    this.trendingNewsGallery,
    this.trendingNewsBanner,
    this.youmayAlsolike,
  });

  int statusCode;
  String msg;
  List<TrendingNewsDetail> trendingNewsDetail;
  List<TrendingNewsGallery> trendingNewsGallery;
  List<TrendingNewsBanner> trendingNewsBanner;
  List<TrendingNewsBanner> youmayAlsolike;

  factory Trendingdetail.fromJson(Map<String, dynamic> json) => Trendingdetail(
        statusCode: json["status_code"] == null ? null : json["status_code"],
        msg: json["msg"] == null ? null : json["msg"],
        trendingNewsDetail: json["trending_news_detail"] == null
            ? null
            : List<TrendingNewsDetail>.from(json["trending_news_detail"]
                .map((x) => TrendingNewsDetail.fromJson(x))),
        trendingNewsGallery: json["trending_news_gallery"] == null
            ? null
            : List<TrendingNewsGallery>.from(json["trending_news_gallery"]
                .map((x) => TrendingNewsGallery.fromJson(x))),
        trendingNewsBanner: json["trending_news_banner"] == null
            ? null
            : List<TrendingNewsBanner>.from(json["trending_news_banner"]
                .map((x) => TrendingNewsBanner.fromJson(x))),
        youmayAlsolike: json["youmay_alsolike"] == null
            ? null
            : List<TrendingNewsBanner>.from(json["youmay_alsolike"]
                .map((x) => TrendingNewsBanner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode == null ? null : statusCode,
        "msg": msg == null ? null : msg,
        "trending_news_detail": trendingNewsDetail == null
            ? null
            : List<dynamic>.from(trendingNewsDetail.map((x) => x.toJson())),
        "trending_news_gallery": trendingNewsGallery == null
            ? null
            : List<dynamic>.from(trendingNewsGallery.map((x) => x.toJson())),
        "trending_news_banner": trendingNewsBanner == null
            ? null
            : List<dynamic>.from(trendingNewsBanner.map((x) => x.toJson())),
        "youmay_alsolike": youmayAlsolike == null
            ? null
            : List<dynamic>.from(youmayAlsolike.map((x) => x.toJson())),
      };
}

class TrendingNewsDetail {
  TrendingNewsDetail({
    this.id,
    this.name,
    this.description,
    this.upProImg,
    this.newsLike,
  });

  String id;
  String name;
  String description;
  String upProImg;
  String newsLike;

  factory TrendingNewsDetail.fromJson(Map<String, dynamic> json) =>
      TrendingNewsDetail(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
        upProImg: json["up_pro_img"] == null ? null : json["up_pro_img"],
        newsLike: json["news_like"] == null ? null : json["news_like"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
        "up_pro_img": upProImg == null ? null : upProImg,
        "news_like": newsLike == null ? null : newsLike,
      };
}

class TrendingNewsGallery {
  TrendingNewsGallery({
    this.id,
    this.tid,
    this.upProImg,
  });

  String id;
  String tid;
  String upProImg;

  factory TrendingNewsGallery.fromJson(Map<String, dynamic> json) =>
      TrendingNewsGallery(
        id: json["id"] == null ? null : json["id"],
        tid: json["tid"] == null ? null : json["tid"],
        upProImg: json["up_pro_img"] == [] ? null : json["up_pro_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "tid": tid == null ? null : tid,
        "up_pro_img": upProImg == null ? null : upProImg,
      };
}
