import 'dart:async';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:saptapadi/model/CheckListModels/checkListtodoData.dart';
import 'package:saptapadi/repository/check_repository.dart';
import 'package:saptapadi/repository/user_repository.dart';
import 'package:saptapadi/route/route_argument.dart';
import 'package:saptapadi/utils/constants.dart';
import 'package:saptapadi/repository/user_repository.dart' as userRepo;

import '../repository/repository.dart';
import '../utils/ads_dialog.dart';

class HomeController extends ControllerMVC {
  List<CheckList> checklistdone = new List<CheckList>();


  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 40), () {
      if (showTime == 2) {
      } else {
        getAds().then((value) {
          showTime = showTime + 1;
          locator<NavigationService>().Showdialog(
              value.popupScreenBanner.upProImg, value.popupScreenBanner.url);
        });
      }
    });
  }

  openNotification()async{
    var result = await Navigator.of(context)
        .pushNamed('/Notifications', arguments: new RouteArgument(param: false));
    if (result == true) {
      userRepo
          .weddingprofile(mobile: currentUser.weddingProfile.userMobile)
          .then((value) {
        setState(() {
          userRepo.currentUser = value;
        });
      });
    }
  }

  openCheckListPage() async {
    var result = await Navigator.of(context)
        .pushNamed('/CheckList', arguments: new RouteArgument(param: false));
    if (result == true) {
      userRepo
          .weddingprofile(mobile: currentUser.weddingProfile.userMobile)
          .then((value) {
        setState(() {
          userRepo.currentUser = value;
        });
      });
    }
  }

  openVendorShortListPage() async {
    var result = await Navigator.of(context).pushNamed(
        '/VendorShortListMainPage',
        arguments: new RouteArgument(param: false));
    if (result == true) {
      userRepo
          .weddingprofile(mobile: currentUser.weddingProfile.userMobile)
          .then((value) {
        setState(() {
          userRepo.currentUser = value;
        });
      });
    }
  }

  getCheckLitdatatodo() async {
    CheckListTodoData checkListData = await checklisttododata();
    if (checkListData.statusCode == 1) {
      setState(() {
        all = checkListData.checkList.length;
        checkListData.checkList.forEach((element) {
          if (element.checklistDone != "") {
            checklistdone.add(element);
            done = checklistdone.length;
          }
        });
        all = checkListData.checkList.length;
      });
    }
  }

  void updateProfilePic(File file) async {
    userRepo.asyncFileUpload(file).then((value) async {
      print(value);
      BotToast.showText(text: value.msg);
      setState(() {});
    });
  }


}
