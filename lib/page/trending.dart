import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/trending_controller.dart';
import 'package:saptapadi/page/treding_details.dart';
import 'package:saptapadi/widget/nav.dart';
import 'package:url_launcher/url_launcher.dart';

class Trending extends StatefulWidget {
  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends StateMVC<Trending> {
  TrendingController _con;

  _TrendingState() : super(TrendingController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: 'Trending Today',
          backicon: false,
        ),
        body: _con.trendingNews.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      // color: Colors.black,
                      height: MediaQuery.of(context).size.height / 2.5,
                      child: Stack(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: _con.trendingNew.upProImg,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          Positioned(
                            bottom: -10,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    transitionDuration:
                                        Duration(milliseconds: 500),
                                    pageBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation) {
                                      return TredingDetails(
                                        trendingID: _con.trendingNew.id,
                                        hero: "",
                                      );
                                    },
                                    transitionsBuilder: (BuildContext context,
                                        Animation<double> animation,
                                        Animation<double> secondaryAnimation,
                                        Widget child) {
                                      return Align(
                                        child: FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                height: 160,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    // color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            _con.trendingNew.name,
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                                fontFamily: 'lato'),
                                          ),
                                          Container(
                                            height: 70,
                                            child: Html(
                                              data:
                                                  _con.trendingNew.description,

                                              // softWrap: true,
                                              // textAlign: TextAlign.center,
                                              // maxLines: 3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      separatorBuilder: (context, position) {
                        final _random = new Random();
                        int a = _random.nextInt(_con.trendingNewsBanner.length);
                        return Container(
                            child: (position != 0 && position % 3 == 0)
                                ? InkWell(
                                    onTap: () {
                                      launchURL(_con.trendingNewsBanner[a].url);
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          _con.trendingNewsBanner[a].upProImg,
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                      fit: BoxFit.cover,
                                      width: 90,
                                      height: 90,
                                    ),
                                  )
                                : Container());
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: _con.trendingNews.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TredingTodaywidget(
                          image: _con.trendingNews[index].upProImg,
                          ontap: () {},
                          title: _con.trendingNews[index].category,
                          details: _con.trendingNews[index].name,
                          trendingID: _con.trendingNews[index].id,
                          hero: "trending",
                        );
                      },
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class TredingTodaywidget extends StatelessWidget {
  final String image;
  final Function ontap;
  final String title;
  final String details;
  final String trendingID;
  final String hero;

  const TredingTodaywidget({
    Key key,
    this.image,
    this.ontap,
    this.title,
    this.details,
    this.trendingID,
    this.hero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return TredingDetails(
                trendingID: trendingID,
                hero: hero,
              );
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return Align(
                child: FadeTransition(
                  opacity: animation,
                  child: child,
                ),
              );
            },
          ),
        );
        /*  Navigator.push(
            context, SizeRoute(page: TredingDetails(trendingID: trendingID,hero: hero,)));*/
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Hero(
                  tag: hero + trendingID,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                    width: 90,
                    height: 90,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.grey, fontFamily: 'lato'),
                  ),
                  Text(
                    details,
                    softWrap: true,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'lato',
                      fontSize: 14,
                      // fontFamily: 'Shruti'
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
