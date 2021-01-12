import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/trending_controller.dart';
import 'package:saptapadi/page/trending.dart';
import 'package:saptapadi/widget/nav.dart';

import 'bottom_navigation_bar.dart';

class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends StateMVC<Favourite> {
  TrendingController _con;

  _FavouriteState() : super(TrendingController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.getFavouriteList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          key: _con.scaffoldKey,
          appBar: Navbar(
            title: "Favourites",
          ),
          body: _con.isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: _con.favouriteData.statusCode == 0
                      ? Container()
                      : Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: _con.favouriteData.favourites.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TredingTodaywidget(
                                  image: _con
                                      .favouriteData.favourites[index].upProImg,
                                  ontap: () {},
                                  title: _con
                                      .favouriteData.favourites[index].category,
                                  details:
                                      _con.favouriteData.favourites[index].name,
                                  trendingID:
                                      _con.favouriteData.favourites[index].id,
                                  hero: "favourite",
                                );
                              },
                            ),
                          ],
                        ),
                )),
    );
  }

  Future<bool> _onBackPressed() {
    return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Bottomnavigationbar(
                currenttab: 4,
              )),
    );
  }
}
