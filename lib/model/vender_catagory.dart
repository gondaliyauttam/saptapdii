import 'dart:convert';

VenderCategory venderCategoryFromJson(String str) =>
    VenderCategory.fromJson(json.decode(str));

String venderCategoryToJson(VenderCategory data) => json.encode(data.toJson());

class VenderCategory {
  VenderCategory({
    this.statusCode,
    this.msg,
    this.vendorsCategory,
  });

  int statusCode;
  String msg;
  List<VendorsCategory> vendorsCategory;

  factory VenderCategory.fromJson(Map<String, dynamic> json) => VenderCategory(
        statusCode: json["status_code"],
        msg: json["msg"],
        vendorsCategory: List<VendorsCategory>.from(
            json["vendors_category"].map((x) => VendorsCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "msg": msg,
        "vendors_category":
            List<dynamic>.from(vendorsCategory.map((x) => x.toJson())),
      };
}

class VendorsCategory {
  VendorsCategory({
    this.id,
    this.name,
    this.upProImg,
  });

  String id;
  String name;
  String upProImg;

  factory VendorsCategory.fromJson(Map<String, dynamic> json) =>
      VendorsCategory(
        id: json["id"],
        name: json["name"],
        upProImg: json["up_pro_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "up_pro_img": upProImg,
      };
}

Vender venderFromJson(String str) => Vender.fromJson(json.decode(str));

String venderToJson(Vender data) => json.encode(data.toJson());

class Vender {
  Vender({
    this.statusCode,
    this.msg,
    this.vendorsList,
    this.vendorsBanner,
  });

  int statusCode;
  String msg;
  List<VendorsList> vendorsList;
  List<VendorsBanner> vendorsBanner;

  factory Vender.fromJson(Map<String, dynamic> json) => Vender(
        statusCode: json["status_code"] == null ? null : json["status_code"],
        msg: json["msg"] == null ? null : json["msg"],
        vendorsList: json["vendors_list"] == null
            ? null
            : List<VendorsList>.from(
                json["vendors_list"].map((x) => VendorsList.fromJson(x))),
        vendorsBanner: json["vendors_banner"] == null
            ? null
            : List<VendorsBanner>.from(
                json["vendors_banner"].map((x) => VendorsBanner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode == null ? null : statusCode,
        "msg": msg == null ? null : msg,
        "vendors_list": vendorsList == null
            ? null
            : List<dynamic>.from(vendorsList.map((x) => x.toJson())),
        "vendors_banner": vendorsBanner == null
            ? []
            : List<dynamic>.from(vendorsBanner.map((x) => x.toJson())),
      };
}

class VendorsBanner {
  VendorsBanner({
    this.id,
    this.name,
    this.url,
    this.upProImg,
  });

  String id;
  String name;
  String url;
  String upProImg;

  factory VendorsBanner.fromJson(Map<String, dynamic> json) => VendorsBanner(
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

class VendorsList {
  VendorsList({
    this.id,
    this.name,
    this.address,
    this.description,
    this.upProImg,
    this.vendorShortlist,
    this.vendorGallery,
  });

  String id;
  String name;
  String address;
  String description;
  String upProImg;
  String vendorShortlist;
  List<VendorGallery> vendorGallery;

  factory VendorsList.fromJson(Map<String, dynamic> json) => VendorsList(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        description: json["description"] == null ? null : json["description"],
        upProImg: json["up_pro_img"] == null ? null : json["up_pro_img"],
        vendorShortlist:
            json["vendor_shortlist"] == null ? null : json["vendor_shortlist"],
        vendorGallery: json["vendor_gallery"] == null
            ? []
            : List<VendorGallery>.from(
                json["vendor_gallery"].map((x) => VendorGallery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "description": description == null ? null : description,
        "up_pro_img": upProImg == null ? null : upProImg,
        "vendor_shortlist": vendorShortlist == null ? null : vendorShortlist,
        "vendor_gallery": vendorGallery == null
            ? []
            : List<dynamic>.from(vendorGallery.map((x) => x.toJson())),
      };
}

class VendorGallery {
  VendorGallery({
    this.vid,
    this.upProImg,
  });

  String vid;
  String upProImg;

  factory VendorGallery.fromJson(Map<String, dynamic> json) => VendorGallery(
        vid: json["vid"] == null ? null : json["vid"],
        upProImg: json["up_pro_img"] == null ? null : json["up_pro_img"],
      );

  Map<String, dynamic> toJson() => {
        "vid": vid == null ? null : vid,
        "up_pro_img": upProImg == null ? null : upProImg,
      };
}

VenderDetails venderDetailsFromJson(String str) =>
    VenderDetails.fromJson(json.decode(str));

String venderDetailsToJson(VenderDetails data) => json.encode(data.toJson());

class VenderDetails {
  VenderDetails({
    this.name,
    this.contactNo,
    this.whatsappMobile,
    this.address,
    this.description,
    this.facebook,
    this.instagram,
    this.youtube,
    this.twitter,
    this.pintrest,
    this.upProImg,
    this.vendorShortlist,
    this.statusCode,
    this.msg,
    this.vendorsGallery,
  });

  String name;
  String contactNo;
  String whatsappMobile;
  String address;
  String description;
  String facebook;
  String instagram;
  String youtube;
  String twitter;
  String pintrest;
  String upProImg;
  String vendorShortlist;
  int statusCode;
  String msg;
  List<VendorGallery> vendorsGallery;

  factory VenderDetails.fromJson(Map<String, dynamic> json) => VenderDetails(
        name: json["name"] == null ? null : json["name"],
        contactNo: json["contact_no"] == null ? null : json["contact_no"],
        whatsappMobile:
            json["whatsapp_mobile"] == null ? null : json["whatsapp_mobile"],
        address: json["address"] == null ? null : json["address"],
        description: json["description"] == null ? null : json["description"],
        facebook: json["facebook"] == null ? null : json["facebook"],
        instagram: json["instagram"] == null ? null : json["instagram"],
        youtube: json["youtube"] == null ? null : json["youtube"],
        twitter: json["twitter"] == null ? null : json["twitter"],
        pintrest: json["pintrest"] == null ? null : json["pintrest"],
        upProImg: json["up_pro_img"] == null ? [] : json["up_pro_img"],
        vendorShortlist:
            json["vendor_shortlist"] == null ? null : json["vendor_shortlist"],
        statusCode: json["status_code"] == null ? null : json["status_code"],
        msg: json["msg"] == null ? null : json["msg"],
        vendorsGallery: json["vendors_gallery"] == null
            ? []
            : List<VendorGallery>.from(
                json["vendors_gallery"].map((x) => VendorGallery.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "contact_no": contactNo == null ? null : contactNo,
        "whatsapp_mobile": whatsappMobile == null ? null : whatsappMobile,
        "address": address == null ? null : address,
        "description": description == null ? null : description,
        "facebook": facebook == null ? null : facebook,
        "instagram": instagram == null ? null : instagram,
        "youtube": youtube == null ? null : youtube,
        "twitter": twitter == null ? null : twitter,
        "pintrest": pintrest == null ? null : pintrest,
        "up_pro_img": upProImg == null ? null : upProImg,
        "vendor_shortlist": vendorShortlist == null ? null : vendorShortlist,
        "status_code": statusCode == null ? null : statusCode,
        "msg": msg == null ? null : msg,
        "vendors_gallery": vendorsGallery == null
            ? null
            : List<dynamic>.from(vendorsGallery.map((x) => x.toJson())),
      };
}

