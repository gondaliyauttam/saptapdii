import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/notification_data.dart';
import 'package:saptapadi/model/notification_details_data.dart';
import 'package:saptapadi/repository/repository.dart';

class NotificationController extends ControllerMVC {
  NotificationData notificationData;
  NotificationDetailsData notificationDetailsData;
  GlobalKey<ScaffoldState> scaffoldKey;

  NotificationController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    getNotificationbanner();
  }

  void getNotificationbanner() async {
    getNotificationandBanner().then((value) async {
      print(value);
      setState(() {});
      notificationData = value;
    });
  }

  void getnotificationDetails(nid) async {
    getNotificationDetails(nid).then((value) async {
      print(value);
      setState(() {});
      notificationDetailsData = value;
    });
  }
}
