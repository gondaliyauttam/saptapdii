import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/notification_controller.dart';
import 'package:saptapadi/repository/user_repository.dart';
import 'package:saptapadi/widget/nav.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:html/parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart';

class NotificationDetails extends StatefulWidget {
  String nid;
  NotificationDetails({this.nid});
  @override
  _NotificationDetailsState createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends StateMVC<NotificationDetails> {
  NotificationController _con;

  _NotificationDetailsState() : super(NotificationController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();

    _con.getnotificationDetails(widget.nid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: 'Notification',
      ),
      body: _con.notificationDetailsData != null
          ? SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _con.notificationDetailsData.notificationList[0].name,
                      softWrap: true,
                      textScaleFactor: 1.2,
                      textAlign: TextAlign.start,
                      style: TextStyle(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.network(
                    _con.notificationDetailsData.notificationList[0].upProImg,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /* LikeShare(
                        image: 'assets/trading_detials/img1.png',
                        ontap: () {},
                      ),
                      SizedBox(
                        width: 20,
                      ),*/
                      LikeShare(
                        image: 'assets/trading_detials/img2.png',
                        ontap: () {
                          urlFileShare();
                        },
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Html(
                      data: _con.notificationDetailsData.notificationList[0]
                          .description,
                      shrinkWrap: true,
                    ) /*Text(
                _con.notificationDetailsData.notificationList[0].description,
                textAlign: TextAlign.justify,
              )*/
                    ,
                  ),
                  InkWell(
                      onTap: () {
                        launchURL(_con
                            .notificationDetailsData.notificationBanner.url);
                      },
                      child: CachedNetworkImage(
                        imageUrl: _con.notificationDetailsData
                            .notificationBanner.upProImg,
                      )),
                ],
              ),
            )
          : Container(),
    );
  }

  launchURL(String openURL) async {
    if (await canLaunch(openURL)) {
      await launch(openURL);
    } else {
      throw 'Could not launch $openURL';
    }
  }

  Future<Null> urlFileShare() async {
    final RenderBox box = context.findRenderObject();
    if (Platform.isAndroid) {
      var url = _con.notificationDetailsData.notificationList[0].upProImg;
      var response = await get(url);
      final documentDirectory = (await getExternalStorageDirectory()).path;
      File imgFile = new File('$documentDirectory/flutter.png');
      imgFile.writeAsBytesSync(response.bodyBytes);
      Share.shareFiles(['${documentDirectory}/flutter.png'],
          subject: 'URL File Share',
          text: _con.notificationDetailsData.notificationList[0].name +
              currentUser.settings.newspostSharemsg,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    } else {
      Share.share('Hello, check your share files!',
          subject: 'URL File Share',
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
