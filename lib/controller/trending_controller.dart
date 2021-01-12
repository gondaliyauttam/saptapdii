import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/favourite_data.dart';
import 'package:saptapadi/model/notification_details_data.dart';
import 'package:saptapadi/model/trendingnews.dart';
import 'package:saptapadi/model/wedding_profile_data.dart';
import 'package:saptapadi/repository/repository.dart';

class TrendingController extends ControllerMVC {
  List<TrendingNew> trendingNews = new List<TrendingNew>();
  TrendingNew trendingNew;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  List<TrendingNewsBanner> trendingNewsBanner;
  TrendingNewsDetail trendingdetailmodel;
  TrendingNewsBanner trendingdetailbanner;
  List<TrendingNewsBanner> youmayAlsolike;
  // TrendingNewsGallery trendingNewsGallery;
  List<TrendingNewsGallery> trendingNewsGallery = new List();
  TrendingNewsGallery tGallery= new TrendingNewsGallery();

  FavouriteData favouriteData;
  bool isLoading = true;

  TrendingController() {
    trendingnews().then((value) {
      setState(() {});
      trendingNews = value.trendingNews;
      trendingNew=trendingNews.first;
      trendingNews.removeAt(0);
      trendingNewsBanner = value.trendingNewsBanner;
    });
  }
  getTrendingDetail(String tID) {
    trendindetails(tID).then((value) {
      setState(() {
        trendingdetailmodel = value.trendingNewsDetail[0];
        trendingdetailbanner = value.trendingNewsBanner[0];
        youmayAlsolike = value.youmayAlsolike;
        trendingNewsGallery = value.trendingNewsGallery;
      });

      tGallery.upProImg=trendingdetailmodel.upProImg;
      tGallery.id=trendingdetailmodel.id;
      tGallery.tid="";
      if(trendingNewsGallery!=null){
        trendingNewsGallery.insert(0, tGallery);
      }else{
        trendingNewsGallery = new List();
        trendingNewsGallery.add(tGallery);
      }
    });
  }

  void addTrendingNewsLike(tId) async {
    addtrendingnewslike(tId).then((value) {
      BotToast.showText(text: value.msg);
      if (value.statusCode == 1) {
        setState(() {
          trendingdetailmodel.newsLike = "yes";
        });
      }
    });
  }

  void removeTrendingNewsLike(tId) async {
    removetrendingnewslike(tId).then((value) {
      BotToast.showText(text: value.msg);
      if (value.statusCode == 1) {
        setState(() {
          trendingdetailmodel.newsLike = "";
        });
      }
    });
  }

  getFavouriteList() {
    favourites().then((value) {
      setState(() {
        favouriteData = value;
        if (value.statusCode == 0) {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Container(
              height: 20,
              child: Center(
                child: Text(value.msg),
              ),
            ),
            duration: Duration(
              minutes: 2,
            ),
          ));
        }

        isLoading = false;
      });
    });
  }
}
