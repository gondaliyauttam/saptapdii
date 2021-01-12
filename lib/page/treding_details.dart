import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/trending_controller.dart';
import 'package:saptapadi/repository/user_repository.dart';
import 'package:saptapadi/widget/nav.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart';

class TredingDetails extends StatefulWidget {
  final String trendingID;
  final String hero;

  const TredingDetails({Key key, @required this.trendingID, this.hero})
      : super(key: key);

  @override
  _TredingDetailsState createState() => _TredingDetailsState();
}

class _TredingDetailsState extends StateMVC<TredingDetails> {
  TrendingController _con;
  File imageFile;
  String path;
  String imhrl;

  _TredingDetailsState() : super(TrendingController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    _con.getTrendingDetail(widget.trendingID);
  }

  List<String> listImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: 'Trending Today',
        ),
        body: _con.trendingdetailmodel == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          _con.trendingdetailmodel.name,
                          softWrap: true,
                          textScaleFactor: 1.3,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _con.trendingNewsGallery != null
                        ? Container(
                            height: MediaQuery.of(context).size.height / 3,
                            width: MediaQuery.of(context).size.width,
                            child: Swiper(
                              itemBuilder: (BuildContext context, index) {
                                return Hero(
                                  tag: widget.hero + widget.trendingID,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: _con
                                        .trendingNewsGallery[index].upProImg,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                );
                              },
                              itemCount: _con.trendingNewsGallery.length,
                              autoplay: false,
                              pagination: new SwiperPagination(),
                              loop: false,
                            ),
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    // CachedNetworkImage(
                    //   imageUrl: _con.trendingdetailmodel.upProImg,
                    //   fit: BoxFit.cover,
                    //   placeholder: (context, url) =>
                    //       Center(child: CircularProgressIndicator()),
                    //   errorWidget: (context, url, error) => Icon(Icons.error),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _con.trendingdetailmodel.newsLike == "yes"
                            ? LikeShare(
                                image: 'assets/trading_detials/like_red.png',
                                ontap: () {
                                  _con.removeTrendingNewsLike(
                                      widget.trendingID);
                                },
                              )
                            : LikeShare(
                                image: 'assets/trading_detials/img1.png',
                                ontap: () {
                                  _con.addTrendingNewsLike(widget.trendingID);
                                },
                              ),
                        SizedBox(
                          width: 20,
                        ),
                        LikeShare(
                          image: 'assets/trading_detials/img2.png',
                          ontap: () async {
                            urlFileShare();
                          },
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        parseHtmlString(_con.trendingdetailmodel.description),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    /* Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Html(
                        data: _con.trendingdetailmodel.description,
                      ),
                    ),*/
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        _launchURL(_con.trendingdetailbanner.url);
                      },
                      child: Container(
                        height: 250,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'ADVERTISEMENT',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Center(
                              child: CachedNetworkImage(
                                imageUrl: _con.trendingdetailbanner.upProImg,
                                height: 200,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'You May Also Like',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        height: 180.0,
                        child: ListView.builder(
                          itemCount: _con.youmayAlsolike.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int i) => Card(
                            child: Container(
                              width: 100,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pushReplacement(
                                        PageRouteBuilder(
                                          transitionDuration:
                                              Duration(milliseconds: 500),
                                          pageBuilder: (BuildContext context,
                                              Animation<double> animation,
                                              Animation<double>
                                                  secondaryAnimation) {
                                            return TredingDetails(
                                              trendingID:
                                                  _con.youmayAlsolike[i].id,
                                              hero: "",
                                            );
                                          },
                                          transitionsBuilder:
                                              (BuildContext context,
                                                  Animation<double> animation,
                                                  Animation<double>
                                                      secondaryAnimation,
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
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            _con.youmayAlsolike[i].upProImg,
                                        fit: BoxFit.cover,
                                        width: 130,
                                        height: 100,
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _con.youmayAlsolike[i].name,
                                    maxLines: 3,
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              )
        // _con.trendingNewsDetail == null
        //     ? Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     : ListView.builder(
        //         itemCount: _con.trendingdetailmodel.trendingNewsDetail.length,
        //         itemBuilder: (BuildContext context, int index) {
        //           return Trendingdetailwidget(
        //             title: _con.trendingNewsDetail[index].name,
        //             image: _con.trendingNewsDetail[index].upProImg,
        //             description: _con.trendingNewsDetail[index].description,
        //           );
        //         },
        //       ),
        );
  }

  String parseHtmlString(String htmlString) {
    var document = parse(htmlString);

    String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  Future<Null> urlFileShare() async {
    final RenderBox box = context.findRenderObject();
    if (Platform.isAndroid) {
      var url = _con.trendingNewsGallery[0].upProImg;
      var response = await get(url);
      final documentDirectory = (await getExternalStorageDirectory()).path;
      File imgFile = new File('$documentDirectory/flutter.png');
      imgFile.writeAsBytesSync(response.bodyBytes);
      Share.shareFiles(['${documentDirectory}/flutter.png'],
          text:
              _con.trendingdetailmodel.name + currentUser.settings.appshareMsg,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } else {
      Share.share('Hello, check your share files!',
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }
}

class LikeShare extends StatelessWidget {
  final String image;
  final Function ontap;

  const LikeShare({
    Key key,
    this.image,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Image.asset(
        image,
        height: 30,
        width: 30,
      ),
      onTap: ontap,
    );
  }
}

_launchURL(String openURL) async {
  if (await canLaunch(openURL)) {
    await launch(openURL);
  } else {
    throw 'Could not launch $openURL';
  }
}
