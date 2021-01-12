import 'dart:convert';

import 'dart:io';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:saptapadi/model/ads_data.dart';
import 'package:saptapadi/model/discount_model.dart';
import 'package:saptapadi/model/exhibition_model.dart';
import 'package:saptapadi/model/exibition_detail_data.dart';
import 'package:saptapadi/model/favourite_data.dart';
import 'package:saptapadi/model/help_model.dart';
import 'package:saptapadi/model/homescreenbanner.dart';
import 'package:saptapadi/model/inspiration_detail_data.dart';
import 'package:saptapadi/model/inspiration_model.dart';
import 'package:saptapadi/model/menu_banner.dart';
import 'package:saptapadi/model/notification_data.dart';
import 'package:saptapadi/model/notification_details_data.dart';
import 'package:saptapadi/model/register_model.dart';
import 'package:saptapadi/model/scrachcard_data.dart';
import 'package:saptapadi/model/scratchcard_user_data.dart';
import 'package:saptapadi/model/service_data.dart';
import 'package:saptapadi/model/success_data.dart';
import 'package:saptapadi/model/trendingnews.dart';
import 'package:saptapadi/model/vender_catagory.dart';
import 'package:saptapadi/model/vendor_finalised_data.dart';
import 'package:saptapadi/model/vendor_shortlist_data.dart';
import 'package:saptapadi/repository/user_repository.dart';

Future<HomeScreenBanner> welcome() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_homescreen_banner';

  final client = new http.Client();
  final response = await client.get(
    url,
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return homeScreenBannerFromJson(res);
  }
}

Future<Menubanner> menubanner() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_menu_banner';
  final client = new http.Client();
  final response = await client.get(
    url,
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return menubannerFromJson(res);
  }
}

Registermodel user = Registermodel();

Future<Registermodel> register(Registermodel reg) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}registration';
  final client = new http.Client();
  final response = await client.post(url, body: jsonEncode(reg.toJson()));
  if (response.statusCode == 200) {
    user = Registermodel.fromJson(json.decode(response.body));

    weddingprofile(mobile: reg.mobile);
    setCurrentUserMobile(reg.mobile);
  }
  return user;
}

Future<VenderCategory> vendercatgory() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_vendors_category';
  final client = new http.Client();
  final response = await client.get(
    url,
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return venderCategoryFromJson(res);
  }
}

Future<Vender> getvender(String cID) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_vendors';
  final client = new http.Client();
  final response = await client.post(url,
      body: jsonEncode(<String, String>{
        'user_mobile': currentUser.weddingProfile.userMobile,
        "cid": cID
      }));
  if (response.statusCode == 200) {
    var res = response.body;
    return venderFromJson(res);
  }
}

Future<VenderDetails> getVenderDetails(String vID) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_vendors_detail';
  final client = new http.Client();
  final response = await client.post(url,
      body: jsonEncode(<String, String>{
        'user_mobile': currentUser.weddingProfile.userMobile,
        "vid": vID
      }));
  if (response.statusCode == 200) {
    var res = response.body;
    return venderDetailsFromJson(res);
  }
}

Future<SuccessData> addVendorShortlist(String vID) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}add_vendors_shortlist';
  final client = new http.Client();
  final response = await client.post(url,
      body: jsonEncode(<String, String>{
        'user_mobile': currentUser.weddingProfile.userMobile,
        "vid": vID
      }));
  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}

Future<SuccessData> removeVendorShortlist(String vID) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}remove_vendors_shortlist';
  final client = new http.Client();
  final response = await client.post(url,
      body: jsonEncode(<String, String>{
        'user_mobile': currentUser.weddingProfile.userMobile,
        "vid": vID
      }));
  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}

Future<TrendingNews> trendingnews() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_trending_news';
  final client = new http.Client();
  final response = await client.get(
    url,
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return trendingNewsFromJson(res);
  }
}

Future<Trendingdetail> trendindetails(String tID) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_trending_news_detail';
  final client = new http.Client();
  final response = await client.post(url,
      body: jsonEncode(<String, String>{
        'user_mobile': currentUser.weddingProfile.userMobile,
        "tid": tID
      }));

  if (response.statusCode == 200) {
    var res = response.body;
    return trendingdetailFromJson(res);
  }
}

Future<FavouriteData> favourites() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_trending_news_favourite';
  final client = new http.Client();
  final response = await client.post(url,
      body: jsonEncode(<String, String>{
        'user_mobile': currentUser.weddingProfile.userMobile
      }));
  if (response.statusCode == 200) {
    var res = response.body;
    return favouriteDataFromJson(res);
  }
}

Future<SuccessData> addtrendingnewslike(tID) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}add_trending_news_like';
  final client = new http.Client();
  final response = await client.post(url,
      body: jsonEncode(<String, String>{
        'user_mobile': currentUser.weddingProfile.userMobile,
        "tid": tID
      }));

  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}

Future<SuccessData> removetrendingnewslike(tID) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}remove_trending_news_like';
  final client = new http.Client();
  final response = await client.post(url,
      body: jsonEncode(<String, String>{
        'user_mobile': currentUser.weddingProfile.userMobile,
        "tid": tID
      }));

  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}

Future<InspirationData> inspirations() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_inspiration';
  final client = new http.Client();
  final response = await client.get(
    url,
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return inspirationDataFromJson(res);
  }
}

Future<InspirationDetailData> inspirationsDetail(iId) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_inspiration_detail';
  final client = new http.Client();
  final response = await client.post(url,
      body: jsonEncode(<String, String>{"insp_id": iId}));
  if (response.statusCode == 200) {
    var res = response.body;
    return inspirationDetailDataFromJson(res);
  }
}

Future<ExhibitionData> exihibition() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_exhibition';
  final client = new http.Client();
  final response = await client.get(
    url,
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return exhibitionDataFromJson(res);
  }
}

Future<ExhibitionDetailData> exihibitionDetails(eId) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_exhibition_detail';
  final client = new http.Client();
  final response =
      await client.post(url, body: jsonEncode(<String, String>{"eid": eId}));
  if (response.statusCode == 200) {
    var res = response.body;
    return exhibitionDetailDataFromJson(res);
  }
}

Future<TermConditions> termcondition() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_staticpage';
  final client = new http.Client();
  final response = await client.get(
    url,
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return termConditionsFromJson(res);
  }
}

Future<TermCondition> helpsendData(TermCondition termCondition) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_inquiry';
  final client = new http.Client();
  final response = await client.post(url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(termCondition.toJson()));
  if (response.statusCode == 200) {
    return TermCondition.fromJson(jsonDecode(response.body));
  }
}

Future<DiscountData> discount_offer() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_discount';
  final client = new http.Client();
  final response = await client.get(
    url,
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return discountDataFromJson(res);
  }
}

Future<SuccessData> getService(ServiceData serviceData) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_service';
  final client = new http.Client();
  final response =
      await client.post(url, body: jsonEncode(serviceData.toServiceDataJson()));
  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}

Future<AdsData> getAds() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_popup_banner';
  final client = new http.Client();
  final response = await client.get(
    url,
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return adsDataFromJson(res);
  }
}

Future<ScarchCardData> getScrachcardandBanner() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_scratch_card';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return scarchCardDataFromJson(res);
  }
}

Future<SuccessData> addScrachcardUser(sid) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}add_scratch_card_user';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
      'scratch_card_id': sid,
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}

Future<ScratchCardUserData> getScratchcardUser() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_scratch_card_user';
  final client = new http.Client();
  print(currentUser.weddingProfile.userMobile);
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return scratchCardUserDataFromJson(res);
  }
}

Future<SuccessData> getScratchVerify(giftId, scId, code) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_scratch_card_verify';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
      'gift_id': giftId,
      'scratch_card_id': scId,
      'security_code': code,
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return successDataFromJson(res);
  }
}

Future<NotificationData> getNotificationandBanner() async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_notification';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return notificationDataFromJson(res);
  }
}

Future<NotificationDetailsData> getNotificationDetails(nid) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_notification_detail';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      // 'user_mobile': currentUser.weddingProfile.userMobile,
      'nid': nid,
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return notificationDetailsDataFromJson(res);
  }
}

Future<VendorSortListData> getVendorShortList({cid}) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_vendors_shortlist';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
      'cid': cid,
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return vendorSortListDataFromJson(res);
  }
}

Future<VendorFinalisedData> getVendorSFinalised({cid}) async {
  final String url =
      '${GlobalConfiguration().getValue('api_base_url')}get_vendors_finalised';
  final client = new http.Client();
  final response = await client.post(
    url,
    body: jsonEncode(<String, String>{
      'user_mobile': currentUser.weddingProfile.userMobile,
      'cid': cid,
    }),
  );
  if (response.statusCode == 200) {
    var res = response.body;
    return vendorFinalisedDataFromJson(res);
  }
}
