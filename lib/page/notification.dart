import 'package:bot_toast/bot_toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/controller/notification_controller.dart';
import 'package:saptapadi/page/inspiation.dart';
import 'package:saptapadi/widget/nav.dart';
import 'package:url_launcher/url_launcher.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends StateMVC<Notifications> {
  NotificationController _con;

  _NotificationsState() : super(NotificationController()) {
    _con = controller;
  }

  Future<bool> _onWillPop() async {
    Navigator.of(_con.scaffoldKey.currentContext).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _con.scaffoldKey,
        appBar: Navbar(
          title: 'Notifications',
          buttontitle: 'View All',
          mycartTap: () {},
        ),
        body: Container(
          child: _con.notificationData != null
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            _con.notificationData.notificationList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      '/NotificationDetails',
                                      arguments: _con.notificationData
                                          .notificationList[index].id);
                                },
                                title: Text(
                                  getNotifyDate(
                                    _con.notificationData
                                        .notificationList[index].date,
                                  ),

                                  // _con.notificationData.notificationList[index]
                                  //     .date,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                                subtitle: Text(
                                  _con.notificationData.notificationList[index]
                                      .name,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                ),
                                // trailing: IconButton(
                                //   icon: Image.asset(
                                //     'assets/notification/Delete.png',
                                //     height: 25,
                                //     width: 25,
                                //   ),
                                //   iconSize: 25,
                                //   onPressed: () {
                                //     _con.notificationData.notificationList
                                //         .remove(index);

                                //     //  notifyListeners();
                                //   },
                                // )
                              ),
                              Divider(),
                            ],
                          );
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        _launchURL(
                            _con.notificationData.notificationBanner[0].url);
                      },
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'ADVERTISEMENT',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Center(
                              child: CachedNetworkImage(
                                imageUrl: _con.notificationData
                                    .notificationBanner[0].upProImg,
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
                    /* InkWell(
                      onTap: () {
                        _launchURL(
                            _con.notificationData.notificationBanner[0].url);
                      },
                      child: CachedNetworkImage(
                        imageUrl:
                            _con.notificationData.notificationBanner[0].upProImg,
                      ),
                    ),*/
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}

Future<void> _launchURL(String openURL) async {
  if (await canLaunch(openURL)) {
    await launch(openURL);
  } else {
    throw 'Could not launch $openURL';
  }
}
